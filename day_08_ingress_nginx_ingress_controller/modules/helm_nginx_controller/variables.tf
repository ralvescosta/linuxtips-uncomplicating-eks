variable "project_name" {
  type        = string
  description = "Name of the project for which the subnets are being created"
}

variable "alb_target_group_arn" {
  type        = string
  description = "ARN of the target group for the AWS Load Balancer Controller"
}

variable "autoscaling" {
  type = object({
    minReplicas = number
    maxReplicas = number
  })

  description = "Autoscaling configuration for the NGINX Ingress Controller"

  default = {
    maxReplicas = 3
    minReplicas = 20
  }
}

variable "resources" {
  type = object({
    requests = object({
      cpu    = string
      memory = string
    })
    limits = object({
      cpu    = string
      memory = string
    })
  })

  description = "Resource requests and limits for the NGINX Ingress Controller"

  default = {
    limits = {
      cpu    = "500m"
      memory = "512Mi"
    }
    requests = {
      cpu    = "250m"
      memory = "256Mi"
    }
  }
}