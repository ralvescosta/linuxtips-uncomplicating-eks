module "kms" {
  source       = "./modules/kms"
  project_name = var.project_name
}

module "eks_cluster_role" {
  source       = "./modules/iam_cluster"
  project_name = var.project_name
}

module "eks_nodes_role" {
  source       = "./modules/iam_nodes"
  project_name = var.project_name
}

module "eks" {
  source = "./modules/eks"

  project_name         = var.project_name
  k8s_version          = var.k8s_version
  eks_cluster_role_arn = module.eks_cluster_role.role_arn
  private_subnet_ids   = var.private_subnets
  kms_key_arn          = module.kms.arn

  depends_on = [
    module.kms,
    module.eks_cluster_role,
    module.eks_nodes_role,
  ]
}

module "oidc" {
  source                 = "./modules/oidc"
  aws_eks_cluster_issuer = module.eks.cluster_oidc_issuer
  depends_on             = [module.eks]
}

module "addons" {
  source = "./modules/addons"

  aws_eks_cluster_name       = module.eks.cluster_name
  addon_cni_version          = var.addon_cni_version
  addon_coredns_version      = var.addon_coredns_version
  addon_kubeproxy_version    = var.addon_kubeproxy_version
  addon_pod_identity_version = var.addon_pod_identity_version

  depends_on = [
    module.eks,
    module.oidc,
  ]
}

module "nodes_entry" {
  source = "./modules/nodes_entry"

  aws_eks_cluster_id = module.eks.cluster_id
  eks_nodes_role_arn = module.eks_nodes_role.role_arn

  depends_on = [
    module.eks,
    module.eks_nodes_role,
    module.addons,
  ]
}

module "nodes" {
  source = "./modules/nodes_spot"

  project_name           = var.project_name
  aws_eks_cluster_id     = module.eks.cluster_id
  aws_eks_nodes_role_arn = module.eks_nodes_role.role_arn
  auto_scale_options     = var.auto_scale_options
  nodes_instance_sizes   = var.nodes_instance_sizes
  pod_subnet_ids         = var.pod_subnets

  depends_on = [
    module.eks,
    module.eks_nodes_role,
    module.nodes_entry,
  ]
}

module "kube_metrics_server" {
  source = "./modules/helm_metrics_server"

  use_localstack = var.use_localstack

  depends_on = [
    module.eks,
    module.nodes,
  ]
}

module "kube_state_metrics" {
  source = "./modules/helm_kube_state_metrics"

  use_localstack = var.use_localstack

  depends_on = [
    module.eks,
    module.nodes,
    module.kube_metrics_server,
  ]
}