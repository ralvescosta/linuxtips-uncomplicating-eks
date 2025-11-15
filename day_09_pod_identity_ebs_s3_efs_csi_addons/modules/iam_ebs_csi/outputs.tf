output "role_arn" {
  description = "The ARN of the EBS CSI IAM Role"
  value       = aws_iam_role.ebs_role.arn
}

output "role_id" {
  description = "The ID of the EBS CSI IAM Role"
  value       = aws_iam_role.ebs_role.id
}

output "role_name" {
  description = "The name of the EBS CSI IAM Role"
  value       = aws_iam_role.ebs_role.name
}