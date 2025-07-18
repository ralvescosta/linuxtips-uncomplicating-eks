resource "aws_eks_cluster" "main" {
  name      = var.project_name
  version   = var.k8s_version
  role_arn  = var.eks_cluster_role_arn

  vpc_config {
    subnet_ids = var.private_subnet_ids
  }

  encryption_config {
    provider {
      key_arn = var.kms_key_arn
    }
    resources = ["secrets"]
  }

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  enabled_cluster_log_types = [
    "api", "audit", "authenticator", "controllerManager", "scheduler"
  ]

  zonal_shift_config {
    enabled = true
  }

  tags = {
    "kubernetes.io/cluster/${var.project_name}" = "shared"
  }
}