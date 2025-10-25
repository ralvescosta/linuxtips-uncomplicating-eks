variable "region" {
  type        = string
  description = "AWS region where the EKS cluster is deployed"
}

variable "auto_scale_options" {
  type = object({
    min     = number
    max     = number
    desired = number
  })
  description = "Cluster Autoscaling configurations"
}

variable "autoscaler_role_arn" {
  type        = string
  description = "ARN of the IAM role for the EKS cluster autoscaler"
}

variable "eks_node_group_autoscaling_name" {
  type        = string
  description = "Name of the EKS node group for the cluster autoscaler"
}