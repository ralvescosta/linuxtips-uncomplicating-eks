variable "aws_eks_cluster_id" {
  type        = string
  description = "ID of the EKS cluster"
}

variable "eks_nodes_role_arn" {
  type        = string
  description = "ARN of the IAM role for EKS nodes"
}