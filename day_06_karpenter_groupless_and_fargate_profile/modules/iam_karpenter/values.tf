variable "project_name" {
  type        = string
  description = "Name of the project for which the subnets are being created"
  default     = "my_project" 
}

variable "openid_connect_provider_arn" {
  type        = string
  description = "ARN of the OpenID Connect provider for Karpenter"
}