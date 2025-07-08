variable "project_name" {
  type = string
}

variable "region" {
  type = string
}

variable "use_localstack" {
  type    = bool
  default = true
}

variable "k8s_version" {
  type        = string
  description = "Kubernetes version for the project"
  default     = "1.32"
}

variable "ssm_vpc" {
  type        = string
  description = "SSM ID where the VPC id for the project creation is stored"
}

variable "ssm_public_subnets" {
  type        = list(string)
  description = "List of SSM IDs where the project's public subnets are stored"
}

variable "ssm_private_subnets" {
  type        = list(string)
  description = "List of SSM IDs where the project's private subnets are stored"
}

variable "ssm_pod_subnets" {
  type        = list(string)
  description = "List of SSM IDs where the project's pod subnets are stored"
}

variable "auto_scale_options" {
  type = object({
    min     = number
    max     = number
    desired = number
  })
  description = "Cluster Autoscaling configurations"
}

variable "nodes_instance_sizes" {
  type        = list(string)
  description = "List of instance sizes for the project"
}

variable "addon_cni_version" {
  type        = string
  default     = "v1.19.5-eksbuild.3"
  description = "VPC CNI Addon version"
}

variable "addon_coredns_version" {
  type        = string
  default     = "v1.11.4-eksbuild.14"
  description = "CoreDNS Addon version"
}

variable "addon_kubeproxy_version" {
  type        = string
  default     = "v1.32.3-eksbuild.7"
  description = "Kube-Proxy Addon version"
}

variable "addon_pod_identity_version" {
  type        = string
  default     = "v1.3.8-eksbuild.2"
  description = "Pod Identity Addon version"
}

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