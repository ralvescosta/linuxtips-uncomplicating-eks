variable "vpc_id" {
  type        = string
  description = "VPC ID where the EFS will be created"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs where the EFS will be accessible"
}