resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metrics-server"
  namespace  = "kube-system"

  wait    = false
  replace = true
  version = "7.4.12"

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