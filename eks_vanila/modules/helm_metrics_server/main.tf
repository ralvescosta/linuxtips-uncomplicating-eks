resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "metrics-server"
  namespace  = "kube-system"

  wait    = true
  replace = true
  version = "7.4.12"

  values = [<<-YAML
    apiService:
      create: true
    metricLabelsAllowlist:
      - nodes=[*]
    metricAnnotationsAllowList:
      - nodes=[*]
    commonLabels:
      app.kubernetes.io/name: metrics-server
      app.kubernetes.io/instance: metrics-server
      app.kubernetes.io/version: "5.10.2"
      app.kubernetes.io/managed-by: Helm
      helm.sh/chart: metrics-server-7.4.12
      meta.helm.sh/release-name: metrics-server
      meta.helm.sh/release-namespace: kube-system
  YAML
  ]
}