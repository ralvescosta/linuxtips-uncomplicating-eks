variable "use_localstack" {
  type    = bool
  default = false
}

variable "project_name" {
  type = string
}

variable "region" {
  type = string
}

variable "environment" {
  type        = string
  description = "Environment for the project"
  default     = "dev"
}

variable "profile" {
  type        = string
  description = "AWS CLI profile to use"
  default     = "personal"
}

variable "s3_bucket_name" {
  type        = string
  description = "S3 Bucket name for Terraform state"
  default     = "linuxtips-uncomplicating-eks-tf-state"
}

variable "k8s_version" {
  type        = string
  description = "Kubernetes version for the project"
  default     = "1.33"
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
  default     = "v1.20.4-eksbuild.1"
  description = "VPC CNI Addon version"
}

variable "addon_coredns_version" {
  type        = string
  default     = "v1.12.4-eksbuild.1"
  description = "CoreDNS Addon version"
}

variable "addon_kubeproxy_version" {
  type        = string
  default     = "v1.33.3-eksbuild.10"
  description = "Kube-Proxy Addon version"
}

variable "addon_pod_identity_version" {
  type        = string
  default     = "v1.3.9-eksbuild.3"
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

variable "dns_name" {
  type = string
  description = "DNS name for the ALB Ingress Controller"
  default = "*.ralvescosta.dev"
}

variable "route53_zone_id" {
  type = string
  description = "Route53 Hosted Zone ID for the ALB Ingress Controller"
  default = "Z02655173QY3KX"
}