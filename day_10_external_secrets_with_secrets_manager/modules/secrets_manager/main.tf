resource "aws_secretsmanager_secret" "sm" {
  name        = var.name
  description = "${var.name} managed by Terraform"
}

resource "aws_secretsmanager_secret_version" "sm_version" {
  secret_id     = aws_secretsmanager_secret.sm.id
  secret_string = var.secret_string
}