output "role_arn" {
  description = "The ARN of the Terminator IAM role"
  value       = aws_iam_role.node_termination_handler.arn
}

output "role_id" {
  description = "The ID of the Terminator IAM role"
  value       = aws_iam_role.node_termination_handler.id
}

output "role_name" {
  description = "The name of the Terminator IAM role"
  value       = aws_iam_role.node_termination_handler.name
}

output "policy_arn" {
  description = "The ARN of the Terminator IAM policy"
  value       = aws_iam_policy.node_termination_handler.arn
}

output "policy_id" {
  description = "The ID of the Terminator IAM policy"
  value       = aws_iam_policy.node_termination_handler.id
}