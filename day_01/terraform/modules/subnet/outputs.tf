output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = aws_subnet.main[*].id
}

output "subnet_arns" {
  description = "The ARNs of the subnets"
  value       = aws_subnet.main[*].arn
}