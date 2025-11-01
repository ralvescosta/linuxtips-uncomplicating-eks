variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the load balancer"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where the load balancer will be created"
}