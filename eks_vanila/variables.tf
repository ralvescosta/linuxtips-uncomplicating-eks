variable "use_localstack" {
  type    = bool
  default = true 
}

variable "project_name" {
  type = string
}

variable "region" {
  type = string
}


variable "k8s_version" {
  type        = string
  description = "Kubernetes version for the project"
  default = "1.32"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the project"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnets for the project"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnets for the project"
}

variable "pod_subnets" {
  type        = list(string)
  description = "List of pod subnets for the project"
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
  default     = "v1.18.3-eksbuild.2"
  description = "VPC CNI Addon version"
}

variable "addon_coredns_version" {
  type        = string
  default     = "v1.11.3-eksbuild.1"
  description = "CoreDNS Addon version"
}

variable "addon_kubeproxy_version" {
  type        = string
  default     = "v1.31.2-eksbuild.3"
  description = "Kube-Proxy Addon version"
}

variable "addon_pod_identity_version" {
  type        = string
  default     = "v1.3.4-eksbuild.1"
  description = "Pod Identity Addon version"
}