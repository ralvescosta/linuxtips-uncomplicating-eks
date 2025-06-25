output "role_arn" {
  description = "The ARN of the EKS cluster IAM role"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "role_id" {
  description = "The ID of the EKS cluster IAM role"
  value       = aws_iam_role.eks_cluster_role.id
}

output "role_name" {
  description = "The name of the EKS cluster IAM role"
  value       = aws_iam_role.eks_cluster_role.name
}