variable "s3_bucket_name" {
  type        = string
  description = "S3 Bucket name for Terraform state"
  default     = "linuxtips-uncomplicating-eks-tf-state"
}

variable "environment" {
  type        = string
  description = "Environment for the project"
  default     = "dev"
}