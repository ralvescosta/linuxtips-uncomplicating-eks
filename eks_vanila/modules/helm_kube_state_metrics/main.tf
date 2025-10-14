resource "helm_release" "kube_state_metrics" {
  name             = "kube-state-metrics"
  repository       = "oci://ghcr.io/prometheus-community/charts"
  chart            = "kube-state-metrics"
  namespace        = "kube-system"
  create_namespace = true
  version          = "6.3.0"

  wait    = var.use_localstack ? false : true
  replace = true

  values = [<<-YAML
    securityContext:
      enabled: false
    apiService:
      create: true
    metricLabelsAllowlist:
      - nodes=[*]
    metricAnnotationsAllowList:
      - nodes=[*]
    image:
      repository: bitnamicharts/kube-state-metrics
      tag: 5.1.0
      pullPolicy: IfNotPresent
  YAML
  ]
}