resource "helm_release" "karpenter" {
  name             = "karpenter"
  create_namespace = true
  namespace        = "karpenter"
  repository       = "oci://public.ecr.aws/karpenter"
  chart            = "karpenter"
  version          = "1.8.1"

  values = [<<-YAML
    serviceAccount:
      annotations:
        eks.amazonaws.com/role-arn: ${var.karpenter_role_arn}
    settings:
      clusterName: ${var.project_name}
      clusterEndpoint: ${var.aws_eks_cluster_endpoint}
      interruptionQueue: ${var.aws_sqs_queue_karpenter_name}

    # Note: aws.defaultInstanceProfile is not a standard Karpenter configuration
    # This should be configured through NodePool/EC2NodeClass resources instead
    # Keeping as comment for reference:
    # aws:
    #   defaultInstanceProfile: ${var.aws_nodes_instance_profile_name}
  YAML
  ]
}