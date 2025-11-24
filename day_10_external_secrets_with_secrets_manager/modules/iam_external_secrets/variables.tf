variable "project_name" {
  description = "The name of the project to which this IAM role belongs."
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}