variable "karpenter_capacity" {
  type = list(object({
    name               = string
    workload           = string
    ami_family         = string
    ami_ssm            = string
    instance_family    = list(string)
    instance_sizes     = list(string)
    capacity_type      = list(string)
    availability_zones = list(string)
  }))
}

variable "aws_nodes_instance_profile_name" {
  type        = string
  description = "Name of the instance profile for nodes"
}

variable "aws_eks_amis" {
  type        = list(string)
  description = "List of AMI IDs for the EKS cluster"
}

variable "aws_eks_cluster_security_group_id" {
  type        = string
  description = "Security group ID for the EKS cluster"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the EKS cluster"
}