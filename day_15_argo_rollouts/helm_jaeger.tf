resource "helm_release" "jaeger" {
  name             = "jaeger"
  repository       = "https://jaegertracing.github.io/helm-charts"
  chart            = "jaeger"
  namespace        = "tracing"
  create_namespace = true

  values = [<<-YAML
    allInOne:
      enabled: true
    storage:
      type: memory
    agent:
      enabled: false
    collector:
      enabled: false
      service:
        zipkin:
          port: 9411
    query:
      enabled: false
    provisionDataStore:
      cassandra: false
      kafka: false
      elasticsearch: false
  YAML
  ]

  depends_on = [
    aws_eks_cluster.main,
    helm_release.istiod
  ]
}


resource "kubectl_manifest" "jaeger_gateway" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: jaeger-query
  namespace: tracing
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "${var.jaeger_host}"
YAML

  depends_on = [
    helm_release.jaeger,
    helm_release.istio_ingress
  ]
}

resource "kubectl_manifest" "jaeger_virtual_service" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: jaeger-query
  namespace: tracing
spec:
  hosts:
  - "${var.jaeger_host}"
  gateways:
  - jaeger-query
  http:
  - route:
    - destination:
        host: jaeger-query
        port:
          number: 16686 
YAML

  depends_on = [
    helm_release.jaeger,
    helm_release.istio_ingress
  ]
}