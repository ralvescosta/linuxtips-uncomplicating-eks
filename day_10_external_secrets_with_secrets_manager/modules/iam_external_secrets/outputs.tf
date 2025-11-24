output "role_arn" {
  description = "The ARN of the IAM role for External Secrets."
  value       = aws_iam_role.external_secrets_role.arn
}

output "role_id" {
  description = "The ID of the IAM role for External Secrets."
  value       = aws_iam_role.external_secrets_role.id
}

output "policy_arn" {
  description = "The ARN of the IAM policy for External Secrets."
  value       = aws_iam_policy.external_secrets_policy.arn
}

output "policy_id" {
  description = "The ID of the IAM policy for External Secrets."
  value       = aws_iam_policy.external_secrets_policy.id
}