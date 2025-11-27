resource "helm_release" "metrics_server" {
  count = var.use_localstack ? 0 : 1

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
    containerPort: 10251
    hostNetwork:
      enabled: true
    defaultArgs:
      - --cert-dir=/tmp
      - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
      - --kubelet-use-node-status-port
      - --secure-port=10251
      - --metric-resolution=15s
      - --kubelet-insecure-tls
    replicas: 2
  YAML
  ]
}