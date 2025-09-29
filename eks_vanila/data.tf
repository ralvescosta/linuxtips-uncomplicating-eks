data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_id
}

data "aws_caller_identity" "current" {}