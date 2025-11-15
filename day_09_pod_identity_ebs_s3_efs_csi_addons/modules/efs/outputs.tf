output "efs_arn" {
  value = aws_efs_file_system.main.arn 
}

output "efs_file_system_id" {
  value = aws_efs_file_system.main.id
}

output "efs_role_arn" {
  value = aws_iam_role.efs_role.arn
}

output "efs_security_group_arn" {
  value = aws_security_group.efs.arn
}

output "efs_security_group_id" {
  value = aws_security_group.efs.id
}

