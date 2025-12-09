variable "project_name" {
  type        = string
  description = "Name of the project for tagging purposes"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the EFS will be created"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs where the EFS will be accessible"
}