data "aws_eks_cluster_auth" "default" {
  name = aws_eks_cluster.main.id
}

data "aws_caller_identity" "current" {}

data "aws_ssm_parameter" "karpenter_ami" {
  count = length(var.karpenter_capacity)
  name  = var.karpenter_capacity[count.index].ami_ssm
}