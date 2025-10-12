terraform {
  backend "s3" {
    bucket = "linuxtips-uncomplicating-eks-tf-state"
    key    = "eks/day-02/prod/state"
    region = "us-east-1"
  }
}