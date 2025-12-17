variable "project_name" {
  type        = string
  description = "Nome do projeto / cluster"
}

variable "region" {
  type        = string
  description = "Nome da região onde os recursos serão entregues"
}

variable "profile" {
  type        = string
  description = "AWS CLI profile to use"
  default     = "personal"
}

variable "k8s_version" {
  type        = string
  description = "Versão do kubernetes do projeto"
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
  description = "Configurações de Autoscaling do Cluster"
}

variable "nodes_instance_sizes" {
  type        = list(string)
  description = "Lista de tamanhos das instâncias do projeto"
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

variable "addon_efs_csi_driver_version" {
  type        = string
  default     = "v2.1.13-eksbuild.1"
  description = "EFS CSI Driver Addon version"
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
  type    = string
  default = "*.ralvescosta.dev"
}

variable "route53_hosted_zone" {
  type    = string
  default = "Z00279991SD1HYHQ0HKYW"
}

variable "grafana_host" {
  type        = string
  default     = "grafana.ralvescosta.dev"
  description = "Host do Grafana"
}

variable "jaeger_host" {
  type        = string
  default     = "jaeger.ralvescosta.dev"
  description = "Host do Jaeger"
}

variable "kiali_host" {
  type        = string
  default     = "kiali.ralvescosta.dev"
  description = "Host do Kiali"
}

variable "argo_rollouts_host" {
  type        = string
  default     = "rollouts.ralvescosta.dev"
  description = "Host do Argo Rollouts"
}

variable "istio_version" {
  type        = string
  default     = "1.25.0"
  description = "Istio version to be installed"
}

variable "kiali_version" {
  type        = string
  default     = "2.5.0"
  description = "Kiali version to be installed"
}

variable "keda_version" {
  type        = string
  default     = "2.16.0"
  description = "KEDA version to be installed"
}

variable "argo_rollouts_version" {
  type        = string
  default     = "2.34.1"
  description = "Argo Rollouts version to be installed"
}

variable "istio_gateway_autoscaling" {
  type = object({
    min                   = number
    max                   = number
    target_cpu_percentage = number
  })
  default = {
    min                   = 2
    max                   = 20
    target_cpu_percentage = 60
  }
  description = "Minimum and maximum number of replicas for Istio gateway components"
}