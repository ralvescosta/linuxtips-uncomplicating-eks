output "role_arn" {
  description = "ARN of the IAM role for the controller"
  value       = aws_iam_role.aws_lb_controller.arn
}

output "role_id" {
  description = "ID of the IAM role for the controller"
  value       = aws_iam_role.aws_lb_controller.id
}

output "role_name" {
  description = "Name of the IAM role for the controller"
  value       = aws_iam_role.aws_lb_controller.name
}