terraform {
  backend "s3" {
    bucket  = "linuxtips-uncomplicating-eks-tf-state"
    key     = "eks-vanila/state"
    region  = "us-east-1"
    profile = "personal"
  }
}