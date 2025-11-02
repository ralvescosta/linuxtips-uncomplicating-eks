variable "project_name" {
  type        = string
  description = "Name of the project for which the subnets are being created"
  default     = "my_project"
}

variable "aws_eks_cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
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

variable "addon_ebs_csi_driver_version" {
  type        = string
  default     = "v1.51.1-eksbuild.1"
  description = "EBS CSI Driver Addon version"
}