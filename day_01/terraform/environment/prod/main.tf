module "vpc" {
  source = "../../modules/vpc"

  vpc_name = "linuxtips-uncomplicating-eks-vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_additional_cidrs = [
    "100.64.0.0/16"
  ]

  igw_name = "linuxtips-uncomplicating-eks-igw"
}

module "public_subnets" {
  source = "../../modules/subnet"

  vpc_id  = module.vpc.vpc_id
  subnets = [
    {
      name = "linuxtips-uncomplicating-eks-public-1a"
      cidr = "10.0.48.0/24",
      az   = "us-east-1a"
    },
    {
      name = "linuxtips-uncomplicating-eks-public-1b"
      cidr = "10.0.49.0/24",
      az   = "us-east-1b"
    },
    {
      name = "linuxtips-uncomplicating-eks-public-1c"
      cidr = "10.0.50.0/24",
      az   = "us-east-1c"
    }
  ]
}