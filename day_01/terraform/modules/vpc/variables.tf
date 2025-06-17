variable "vpc_name" {
 type        = string
 description = "Name of the VPC"
 default     = "my-vpc"
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