terraform {
  backend "s3" {
    bucket  = "linuxtips-uncomplicating-eks-tf-state"
    key     = "day_14"
    region  = "us-east-1"
    profile = "personal"
  }
}