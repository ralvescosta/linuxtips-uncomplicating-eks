variable "project_name" {
  type        = string
  description = "Name of the project for which the subnets are being created"
}

variable "alb_target_group_arn" {
  type        = string
  description = "ARN of the target group for the AWS Load Balancer Controller"
}