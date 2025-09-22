output "role_arn" {
  description = "The ARN of the EKS cluster IAM role"
  value       = aws_iam_role.autoscaler.arn
}

output "role_id" {
  description = "The ID of the EKS cluster IAM role"
  value       = aws_iam_role.autoscaler.id
}

output "role_name" {
  description = "The name of the EKS cluster IAM role"
  value       = aws_iam_role.autoscaler.name
}

output "policy_arn" {
  description = "The ARN of the EKS cluster IAM policy"
  value       = aws_iam_policy.autoscaler.arn
}

output "policy_id" {
  description = "The ID of the EKS cluster IAM policy"
  value       = aws_iam_policy.autoscaler.id
}
