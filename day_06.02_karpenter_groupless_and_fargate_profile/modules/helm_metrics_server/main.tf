resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  namespace  = "kube-system"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  version    = "3.13.0"

  wait    = true
  replace = true

  values = [<<-YAML
    apiService:
      create: true
    hostNetwork:
      enabled: true
    replicas: 2
  YAML
  ]
}