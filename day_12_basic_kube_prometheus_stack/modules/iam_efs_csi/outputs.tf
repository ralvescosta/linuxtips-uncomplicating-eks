output "role_arn" {
  description = "The ARN of the efs CSI IAM Role"
  value       = aws_iam_role.efs_role.arn
}

output "role_id" {
  description = "The ID of the efs CSI IAM Role"
  value       = aws_iam_role.efs_role.id
}

output "role_name" {
  description = "The name of the efs CSI IAM Role"
  value       = aws_iam_role.efs_role.name
}