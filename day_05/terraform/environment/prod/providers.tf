terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "aws" {
  region                      = var.region
  s3_use_path_style           = var.use_localstack
  skip_credentials_validation = var.use_localstack
  skip_metadata_api_check     = var.use_localstack
  skip_requesting_account_id  = var.use_localstack

  endpoints {
    apigateway             = var.use_localstack ? "http://localhost:4566" : null
    cloudformation         = var.use_localstack ? "http://localhost:4566" : null
    cloudwatch             = var.use_localstack ? "http://localhost:4566" : null
    dynamodb               = var.use_localstack ? "http://localhost:4566" : null
    cloudwatchlogs         = var.use_localstack ? "http://localhost:4566" : null
    cloudwatchlog          = var.use_localstack ? "http://localhost:4566" : null
    es                     = var.use_localstack ? "http://localhost:4566" : null
    ecs                    = var.use_localstack ? "http://localhost:4566" : null
    ec2                    = var.use_localstack ? "http://localhost:4566" : null
    eks                    = var.use_localstack ? "http://localhost:4566" : null
    ecr                    = var.use_localstack ? "http://localhost:4566" : null
    elb                    = var.use_localstack ? "http://localhost:4566" : null
    elasticloadbalancing   = var.use_localstack ? "http://localhost:4566" : null
    elasticloadbalancingv2 = var.use_localstack ? "http://localhost:4566" : null
    firehose               = var.use_localstack ? "http://localhost:4566" : null
    iam                    = var.use_localstack ? "http://localhost:4566" : null
    kinesis                = var.use_localstack ? "http://localhost:4566" : null
    lambda                 = var.use_localstack ? "http://localhost:4566" : null
    route53                = var.use_localstack ? "http://localhost:4566" : null
    redshift               = var.use_localstack ? "http://localhost:4566" : null
    s3                     = var.use_localstack ? "http://s3.localhost.localstack.cloud:4566" : null
    secretsmanager         = var.use_localstack ? "http://localhost:4566" : null
    ses                    = var.use_localstack ? "http://localhost:4566" : null
    sns                    = var.use_localstack ? "http://localhost:4566" : null
    sqs                    = var.use_localstack ? "http://localhost:4566" : null
    ssm                    = var.use_localstack ? "http://localhost:4566" : null
    sts                    = var.use_localstack ? "http://localhost:4566" : null
    servicediscovery       = var.use_localstack ? "http://localhost:4566" : null
    kms                    = var.use_localstack ? "http://localhost:4566" : null
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.default.token
}

provider "helm" {
  kubernetes = {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.default.token
  }
}