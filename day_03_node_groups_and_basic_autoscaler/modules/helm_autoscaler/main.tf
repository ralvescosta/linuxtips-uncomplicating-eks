resource "helm_release" "cluster_autoscaler" {
  repository = "https://kubernetes.github.io/autoscaler"

  chart            = "cluster-autoscaler"
  name             = "aws-cluster-autoscaler"
  namespace        = "kube-system"
  create_namespace = true

  set = [
    {
      name  = "replicaCount"
      value = 1
    },
    {
      name  = "awsRegion"
      value = var.region
    },
    {
      name  = "rbac.serviceAccount.create"
      value = true
    },
    {
      name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = var.autoscaler_role_arn
    },
    {
      name  = "autoscalingGroups[0].name"
      value = var.eks_node_group_autoscaling_name
    },
    {
      name  = "autoscalingGroups[0].maxSize"
      value = lookup(var.auto_scale_options, "max")
    },
    {
      name  = "autoscalingGroups[0].minSize"
      value = lookup(var.auto_scale_options, "min")
    }
  ]
}