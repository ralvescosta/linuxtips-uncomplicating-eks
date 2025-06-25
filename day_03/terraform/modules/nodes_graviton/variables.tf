variable "project_name" {
  type        = string
  description = "Name of the project for which the subnets are being created"
  default     = "my_project" 
}

variable "aws_eks_cluster_id" {
  type        = string
  description = "ID of the EKS cluster to which the node group will be attached"
}

variable "aws_eks_nodes_role_arn" {
  type        = string
  description = "ARN of the IAM role for the EKS nodes"
}

variable "auto_scale_options" {
  type = map(number)
  description = "Auto scaling options for the EKS node group, including desired, max, and min sizes"
  default = {
    desired = 2
    max     = 5
    min     = 1
  }
}

variable "nodes_instance_sizes" {
  type        = list(string)
  description = "List of instance types for the EKS nodes"
  default     = ["t3.medium"]
}

variable "pod_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs where the EKS nodes will be deployed"
  default     = []
}