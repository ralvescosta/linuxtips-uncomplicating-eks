variable "region" {
  type        = string
  description = "AWS region where the EKS cluster is deployed"
}

variable "node_termination_role_arn" {
  type        = string
  description = "ARN of the IAM role for the EKS node termination handler"
}

variable "sqs_queue_url" {
  type        = string
  description = "URL of the SQS queue"
}