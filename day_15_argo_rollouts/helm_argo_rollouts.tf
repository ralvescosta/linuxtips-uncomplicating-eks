resource "helm_release" "argo_rollouts" {
  name       = "argo-rollouts"
  chart      = "argo-rollouts"
  repository = "https://argoproj.github.io/argo-helm"
  namespace  = "argo-rollouts"

  version = var.argo_rollouts_version

  create_namespace = true

  values = [<<-YAML
    dashboard:
      enabled: true
    controller:
      metrics:
        enabled: true
        serviceMonitor:
          enabled: true
  YAML
  ]

  depends_on = [
    helm_release.karpenter,
    helm_release.istio_ingress
  ]
}

resource "kubectl_manifest" "rollouts_gateway" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: argo-gateway
  namespace: argo-rollouts
spec:
  selector:
    istio: ingressgateway 
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - ${var.argo_rollouts_host}
YAML

  depends_on = [
    helm_release.argo_rollouts
  ]
}

resource "kubectl_manifest" "rollouts_virtual_service" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: argo-rollouts
  namespace: argo-rollouts
spec:
  hosts:
  - ${var.argo_rollouts_host}
  gateways:
  - argo-gateway
  http:
  - match:
    - uri:
        prefix: /
    route:
    - destination:
        host: argo-rollouts-dashboard
        port:
          number: 3100
YAML

  depends_on = [
    helm_release.argo_rollouts
  ]
}