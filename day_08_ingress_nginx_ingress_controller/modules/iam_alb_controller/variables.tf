variable "project_name" {
  type        = string
  description = "Name of the project for which the subnets are being created"
  default     = "my_project"
}

variable "cluster_endpoint" {
  type        = string
  description = "EKS Cluster endpoint URL"
}

variable "oidc_provider_arn" {
  type        = string
  description = "ARN of the OIDC provider associated with the EKS cluster"
}