resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true

  name       = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  version    = "1.0.8"

  values = [<<-YAML
    serviceAccount:
      annotations:
        eks.amazonaws.com/role-arn: ${aws_iam_role.karpenter.arn}
    settings:
      clusterName: ${var.project_name}
      clusterEndpoint: ${aws_eks_cluster.main.endpoint}
      interruptionQueue: ${aws_sqs_queue.karpenter.name}
    aws:
      defaultInstanceProfile: ${aws_iam_instance_profile.nodes.name}
  YAML
  ]

  depends_on = [
    aws_eks_cluster.main,
    aws_eks_node_group.main,
    aws_sqs_queue.karpenter,
    aws_iam_role.karpenter,
    aws_iam_instance_profile.nodes,
  ]
}