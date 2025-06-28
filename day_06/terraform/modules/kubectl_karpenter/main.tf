resource "kubectl_manifest" "ec2_node_class" {
  count = length(var.karpenter_capacity)
  yaml_body = templatefile("${path.module}/ec2_node_class.yaml", {
    NAME              = var.karpenter_capacity[count.index].name
    INSTANCE_PROFILE  = var.aws_nodes_instance_profile_name
    AMI_ID            = var.aws_eks_amis[count.index]
    AMI_FAMILY        = var.karpenter_capacity[count.index].ami_family
    SECURITY_GROUP_ID = var.aws_eks_cluster_security_group_id
    SUBNETS           = var.subnet_ids[*]
  })
}

resource "kubectl_manifest" "nodepool" {
  count = length(var.karpenter_capacity)
  yaml_body = templatefile("${path.module}/nodepool.yaml", {
    NAME               = var.karpenter_capacity[count.index].name
    WORKLOAD           = var.karpenter_capacity[count.index].workload
    INSTANCE_FAMILY    = var.karpenter_capacity[count.index].instance_family
    INSTANCE_SIZES     = var.karpenter_capacity[count.index].instance_sizes
    CAPACITY_TYPE      = var.karpenter_capacity[count.index].capacity_type
    AVAILABILITY_ZONES = var.karpenter_capacity[count.index].availability_zones
  })
}