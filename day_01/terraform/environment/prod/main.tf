module "vpc" {
  source = "../../modules/vpc"

  vpc_name = "linuxtips-uncomplicating-eks-vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_additional_cidrs = [
    "100.64.0.0/16"
  ]
}