variable "project_name" {
  type        = string
  description = "Name of the project for which the subnets are being created"
  default     = "my_project"
}

variable "karpenter_role_arn" {
  type        = string
  description = "ARN of the IAM role for Karpenter"
}

variable "aws_eks_cluster_endpoint" {
  type        = string
  description = "Endpoint of the EKS cluster"
}

variable "aws_nodes_instance_profile_name" {
  type        = string
  description = "Name of the instance profile for nodes"
}

variable "sqs_interruption_queue_name" {
  type        = string
  description = "Name of the SQS interruption queue for Karpenter"
}