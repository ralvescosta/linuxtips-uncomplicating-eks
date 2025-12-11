resource "helm_release" "kube_state_metrics" {
  name             = "kube-state-metrics"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-state-metrics"
  namespace        = "kube-system"
  create_namespace = true

  values = [<<-YAML
    apiService:
      create: true
    
    metricLabelsAllowlist:
      - "nodes=[*]"
    
    metricAnnotationsAllowList:
      - "nodes=[*]"
  YAML
  ]

  depends_on = [
    aws_eks_cluster.main,
    aws_eks_fargate_profile.karpenter
  ]
}