resource "helm_release" "kube_state_metrics" {
  name             = "kube-state-metrics"
  repository       = "oci://ghcr.io/prometheus-community/charts"
  chart            = "kube-state-metrics"
  namespace        = "kube-system"
  create_namespace = true
  version          = "6.3.0"

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
    aws_eks_node_group.main,
  ]
}