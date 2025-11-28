data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_id
}

data "aws_caller_identity" "current" {}

resource "aws_ssm_parameter" "eks_ami_local" {
  count = var.use_localstack ? 1 : 0

  name  = "/aws/service/eks/optimized-ami/1.33/amazon-linux-2023/x86_64/standard/recommended/image_id"
  type  = "String"
  value = "ami-cd82fe08"
}

data "aws_ssm_parameter" "karpenter_ami" {
  count = length(var.karpenter_capacity)
  name  = var.karpenter_capacity[count.index].ami_ssm

  depends_on = [aws_ssm_parameter.eks_ami_local]
}