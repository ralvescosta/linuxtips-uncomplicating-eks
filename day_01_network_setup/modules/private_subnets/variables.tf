variable "project_name" {
  type        = string
  description = "Name of the project for which the subnets are being created"
  default     = "my_project"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC to create the subnets in"
}

variable "public_subnets" {
  type = list(object({
    id   = string
    arn  = string
    name = string
    cidr = string
    az   = string
  }))
  description = "List of subnets to create, each with a name and CIDR block"
}

variable "private_subnets" {
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))
  description = "List of subnets to create, each with a name and CIDR block"
}