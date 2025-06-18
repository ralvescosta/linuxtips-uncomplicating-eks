module "vpc" {
  source = "../../modules/vpc"

  vpc_name = "${var.project_name}-vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_additional_cidrs = [
    "100.64.0.0/16"
  ]

  igw_name = "${var.project_name}-igw"
}

module "public_subnets" {
  source = "../../modules/subnet"

  route_table_name = "${var.project_name}-public-rt"
  route_destination_cidr = "0.0.0.0/0"
  route_gateway_id = module.vpc.igw_id

  vpc_id  = module.vpc.vpc_id
  subnets = [
    {
      name = "${var.project_name}-public-1a"
      cidr = "10.0.48.0/24",
      az   = "us-east-1a"
    },
    {
      name = "${var.project_name}-public-1b"
      cidr = "10.0.49.0/24",
      az   = "us-east-1b"
    },
    {
      name = "${var.project_name}-public-1c"
      cidr = "10.0.50.0/24",
      az   = "us-east-1c"
    }
  ]
}