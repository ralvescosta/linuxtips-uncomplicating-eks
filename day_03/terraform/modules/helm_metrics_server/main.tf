resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metrics-server"
  namespace  = "kube-system"

  wait    = false
  replace = true
  version = "7.2.16"

  set = [
    {
      name  = "apiService.create"
      value = "true"
    }
  ]
}