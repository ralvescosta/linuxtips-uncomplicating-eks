output "name" {
  description = "Name of the KMS key"
  value       = aws_kms_key.main.key_id
}

output "arn" {
  description = "ARN of the KMS key"
  value       = aws_kms_key.main.arn
}

output "key_id" {
  description = "ID of the KMS key"
  value       = aws_kms_key.main.id
}

output "alias" {
  description = "Alias of the KMS key"
  value       = aws_kms_alias.main.name
}
