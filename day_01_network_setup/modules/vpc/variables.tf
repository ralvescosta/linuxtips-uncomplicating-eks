variable "project_name" {
  type        = string
  description = "Name of the project for which the subnets are being created"
  default     = "my_project"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "vpc_additional_cidrs" {
  type        = list(string)
  description = "Additional CIDR blocks for the VPC"
  default     = []
}
