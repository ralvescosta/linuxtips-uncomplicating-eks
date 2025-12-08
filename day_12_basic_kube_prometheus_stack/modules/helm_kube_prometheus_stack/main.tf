resource "helm_release" "prometheus" {
  name             = "prometheus"
  chart            = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  namespace        = "prometheus"
  create_namespace = true

  version = "69.3.2"

  values = [
    "${file("./modules/helm_kube_prometheus_stack/values.yaml")}"
  ]
}