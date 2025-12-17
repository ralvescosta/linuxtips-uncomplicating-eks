resource "helm_release" "kiali_server" {
  name       = "kiali-server"
  chart      = "kiali-server"
  repository = "https://kiali.org/helm-charts"
  namespace  = "istio-system"

  create_namespace = true

  version = var.kiali_version

  values = [<<-YAML
    server:
      web_fqdn: ${var.kiali_host}
    auth:
      strategy: anonymous
    external_services:
      tracing:
        use_grpc: false
        enabled: true
        internal_url: http://jaeger-query.tracing.svc.cluster.local:16686
        external_url: http://${var.jaeger_host}
      prometheus:
        url: http://prometheus-kube-prometheus-prometheus.prometheus.svc.cluster.local:9090
      grafana:
        enabled: true
        external_url: http://${var.grafana_host}
        internal_url: http://prometheus-grafana.prometheus.svc.cluster.local:80
        auth:
          type: basic
          insecure_skip_verify: true
          username: admin
          password: linuxtips
        dashboards:
          - name: Istio Mesh Dashboard
          - name: Istio Service Dashboard
            variables:
              namespace: var-namespace
              service: var-service
          - name: Istio Workload Dashboard
            variables:
              namespace: var-namespace
              workload: var-workload
          - name: Istio Performance Dashboard
    YAML
  ]

  depends_on = [
    helm_release.istio_base,
    helm_release.istiod,
    helm_release.istio_ingress
  ]
}

resource "kubectl_manifest" "kiali_gateway" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: kiali-gateway
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway 
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - ${var.kiali_host}
YAML

  depends_on = [
    helm_release.kiali_server,
  ]
}

resource "kubectl_manifest" "kiali_virtual_service" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: kiali
  namespace: istio-system
spec:
  hosts:
  - ${var.kiali_host}
  gateways:
  - kiali-gateway
  http:
  - match:
    - uri:
        prefix: /
    route:
    - destination:
        host: kiali
        port:
          number: 20001
YAML

  depends_on = [
    helm_release.kiali_server,
  ]
}