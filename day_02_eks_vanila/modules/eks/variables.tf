variable "project_name" {
  type        = string
  description = "Name of the project for which the subnets are being created"
  default     = "my_project" 
}

variable "k8s_version" {
  type        = string
  description = "Kubernetes version for the project"
  default = "1.31"
}

variable "eks_cluster_role_arn" {
  type        = string
  description = "ARN of the IAM role for the EKS cluster"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for the EKS cluster"
  default     = []
}

variable "kms_key_arn" {
  type        = string
  description = "ARN of the KMS key for EKS encryption"
}

