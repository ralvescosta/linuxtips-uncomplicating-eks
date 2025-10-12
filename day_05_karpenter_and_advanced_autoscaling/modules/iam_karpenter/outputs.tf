output "role_arn" {
  description = "The ARN of the EKS cluster IAM role"
  value       = aws_iam_role.karpenter.arn
}

output "role_id" {
  description = "The ID of the EKS cluster IAM role"
  value       = aws_iam_role.karpenter.id
}

output "role_name" {
  description = "The name of the EKS cluster IAM role"
  value       = aws_iam_role.karpenter.name
}

output "policy_arn" {
  description = "The ARN of the EKS cluster IAM role policy"
  value       = aws_iam_policy.karpenter.arn
}

output "policy_id" {
  description = "The ID of the EKS cluster IAM role policy"
  value       = aws_iam_policy.karpenter.id
}