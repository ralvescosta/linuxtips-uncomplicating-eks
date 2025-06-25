module "kms" {
  source       = "../../modules/kms"
  project_name = var.project_name
}

module "eks_cluster_role" {
  source       = "../../modules/iam_cluster"
  project_name = var.project_name
}

module "eks_nodes_role" {
  source       = "../../modules/iam_nodes"
  project_name = var.project_name
}

module "eks" {
  source = "../../modules/eks"

  project_name         = var.project_name
  k8s_version          = var.k8s_version
  eks_cluster_role_arn = module.eks_cluster_role.role_arn
  private_subnet_ids   = data.aws_ssm_parameter.private_subnets[*].value
  kms_key_arn          = module.kms.arn

  depends_on = [
    module.kms,
    module.eks_cluster_role,
  ]
}

module "oidc" {
  source = "../../modules/oidc"

  aws_eks_cluster_issuer = module.eks.cluster_oidc_issuer

  depends_on = [module.eks]
}

module "addons" {
  source = "../../modules/addons"

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
  source = "../../modules/nodes_entry"

  aws_eks_cluster_id = module.eks.cluster_id
  eks_nodes_role_arn = module.eks_nodes_role.role_arn

  depends_on = [
    module.eks,
    module.eks_nodes_role,
  ]
}

module "spot_nodes" {
  source = "../../modules/nodes_spot"

  project_name           = var.project_name
  aws_eks_cluster_id     = module.eks.cluster_id
  aws_eks_nodes_role_arn = module.eks_nodes_role.role_arn
  auto_scale_options     = var.auto_scale_options
  nodes_instance_sizes   = var.nodes_instance_sizes
  pod_subnet_ids         = data.aws_ssm_parameter.pod_subnets[*].value

  depends_on = [
    module.eks_nodes_role,
    module.eks,
    module.nodes_entry,
  ]
}

module "kube_metrics_server" {
  source = "../../modules/helm_metrics_server"

  depends_on = [
    module.eks,
    module.nodes_entry,
    module.spot_nodes,
  ]
}

module "kube_state_metrics" {
  source = "../../modules/helm_kube_state_metrics"

  depends_on = [
    module.eks,
    module.nodes_entry,
    module.spot_nodes,
  ]
}

module "eks_autoscaler_role" {
  source = "../../modules/iam_cluster_autoscaler"

  project_name                = var.project_name
  openid_connect_provider_arn = module.oidc.openid_connect_provider_arn
}

module "eks_autoscaler" {
  source = "../../modules/helm_autoscaler"

  region                          = var.region
  auto_scale_options              = var.auto_scale_options
  autoscaler_role_arn             = module.eks_autoscaler_role.role_arn
  eks_node_group_autoscaling_name = module.spot_nodes.eks_node_group_autoscaling_name

  depends_on = [
    module.eks,
    module.spot_nodes,
    module.eks_autoscaler_role,
  ]
}