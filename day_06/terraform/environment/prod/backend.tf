terraform {
  backend "s3" {
    bucket = "linuxtips-uncomplicating-eks-tf-state"
    key    = "eks/day-05/prod/state"
    region = "us-east-1"
  }
}