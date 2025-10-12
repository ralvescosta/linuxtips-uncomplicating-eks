terraform {
  backend "s3" {
    bucket  = "linuxtips-uncomplicating-eks-tf-state"
    key     = "eks-vanila/state"
    region  = "us-east-1"
    # AWS configuration
    # profile = "personal"

    # LocalStack configuration
    profile = "localstack"
    endpoints = {
      s3  = "http://localhost:4566"
      sts = "http://localhost:4566"
    }
  }
}