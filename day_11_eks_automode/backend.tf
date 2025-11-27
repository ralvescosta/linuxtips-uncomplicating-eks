terraform {
  backend "s3" {
    bucket = "linuxtips-uncomplicating-eks-tf-state"
    key    = "day_11"
    region = "us-east-1"
    # AWS configuration
    profile = "personal"

    # LocalStack configuration
    # profile = "localstack"
    # endpoints = {
    #   s3  = "http://s3.localhost.localstack.cloud:4566"
    #   sts = "http://localhost:4566"
    # }
  }
}