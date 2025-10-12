resource "helm_release" "kube_state_metrics" {
  name             = "kube-state-metrics"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-state-metrics"
  namespace        = "kube-system"
  create_namespace = true
  version          = "6.3.0"

  wait = true
  replace = true

  values = [<<-YAML
    apiService:
      create: true
    metricLabelsAllowlist:
      - nodes=[*]
    metricAnnotationsAllowList:
      - nodes=[*]
  YAML
  ]
}