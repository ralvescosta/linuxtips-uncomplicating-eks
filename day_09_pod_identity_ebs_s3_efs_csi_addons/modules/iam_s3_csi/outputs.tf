output "role_arn" {
  description = "The ARN of the s3 CSI IAM Role"
  value       = aws_iam_role.s3_role.arn
}

output "role_id" {
  description = "The ID of the s3 CSI IAM Role"
  value       = aws_iam_role.s3_role.id
}

output "role_name" {
  description = "The name of the s3 CSI IAM Role"
  value       = aws_iam_role.s3_role.name
}