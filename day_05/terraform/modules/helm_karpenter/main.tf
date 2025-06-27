resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true

  name       = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  version    = "1.0.8"

  set = [
    {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = var.karpenter_role_arn
    },
    {
      name  = "settings.clusterName"
      value = var.project_name
    },
    {
      name  = "settings.clusterEndpoint"
      value = var.aws_eks_cluster_endpoint
    },
    {
      name  = "aws.defaultInstanceProfile"
      value = var.aws_nodes_instance_profile_name
    },
    {
      name  = "settings.interruptionQueue"
      value = var.aws_sqs_queue_karpenter_name
    }
  ]
}