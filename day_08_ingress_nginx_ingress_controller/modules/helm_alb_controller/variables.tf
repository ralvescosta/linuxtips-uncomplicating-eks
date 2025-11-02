variable "project_name" {
  type        = string
  description = "Name of the project for which the subnets are being created"
}

variable "region" {
  type        = string
  description = "AWS region where the resources will be created"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the ALB controller will be deployed"
}

variable "alb_controller_role_arn" {
  type        = string
  description = "ARN of the IAM role for the AWS Load Balancer Controller"
}