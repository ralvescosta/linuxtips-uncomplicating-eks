output "name" {
  description = "Secret Manager name"
  value = aws_secretsmanager_secret.sm.name
}

output "arn" {
  description = "Secret Manager ARN"
  value = aws_secretsmanager_secret.sm.arn
}