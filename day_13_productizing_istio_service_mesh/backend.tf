terraform {
  backend "s3" {
    bucket = "linuxtips-uncomplicating-eks-tf-state"
    key    = "day_13"
    region = "us-east-1"
    profile = "personal"
  }
}