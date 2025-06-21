module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  vpc_cidr     = "10.0.0.0/16"

  vpc_additional_cidrs = [
    "100.64.0.0/16"
  ]
}

module "public_subnets" {
  source = "../../modules/public_subnets"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  igw_id       = module.vpc.igw_id

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

  depends_on = [module.vpc]
}

module "private_subnets" {
  source = "../../modules/private_subnets"

  project_name   = var.project_name
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.public_subnets.subnets_details

  private_subnets = [
    # general propose
    {
      name = "${var.project_name}-private-1a"
      cidr = "10.0.0.0/20",
      az   = "us-east-1a"
    },
    {
      name = "${var.project_name}-private-1b"
      cidr = "10.0.16.0/20",
      az   = "us-east-1b"
    },
    {
      name = "${var.project_name}-private-1c"
      cidr = "10.0.32.0/20",
      az   = "us-east-1c"
    },
    # pods
    {
      name = "${var.project_name}-pods-1a"
      cidr = "100.64.0.0/18",
      az   = "us-east-1a"
    },
    {
      name = "${var.project_name}-pods-1b"
      cidr = "100.64.64.0/18",
      az   = "us-east-1b"
    },
    {
      name = "${var.project_name}-pods-1c"
      cidr = "100.64.128.0/18",
      az   = "us-east-1c"
    }
  ]

  depends_on = [module.public_subnets]
}

module "database_subnets" {
  source = "../../modules/database_subnets"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id

  database_subnets = [
    {
      name = "${var.project_name}-database-1a"
      cidr = "10.0.51.0/24",
      az   = "us-east-1a"
    },
    {
      name = "${var.project_name}-database-1b"
      cidr = "10.0.52.0/24",
      az   = "us-east-1b"
    },
    {
      name = "${var.project_name}-database-1c"
      cidr = "10.0.53.0/24",
      az   = "us-east-1c"
    }
  ]
}

module "parameters" {
  source = "../../modules/parameter_store"

  project_name     = var.project_name
  vpc_id           = module.vpc.vpc_id
  public_subnets   = module.public_subnets.subnets_details
  private_subnets  = module.private_subnets.subnets_details
  database_subnets = module.database_subnets.subnets_details

  depends_on = [
    module.vpc,
    module.public_subnets,
    module.private_subnets,
    module.database_subnets
  ]
}