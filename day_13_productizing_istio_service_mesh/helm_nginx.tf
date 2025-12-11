resource "helm_release" "nginx_controller" {
  name       = "ingress-nginx"
  namespace  = "ingress-nginx"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = "4.11.3"

  create_namespace = true

  values = [<<-YAML
    controller:
      service:
        internal:
          enabled: true
        type: NodePort
      publishService:
        enable: true
      autoscaling:
        enabled: true
        minReplicas: ${var.nginx_min_replicas}
        maxReplicas: ${var.nginx_max_replicas}
      resources:
        requests:
          cpu: ${var.nginx_requests_cpu}
          memory: ${var.nginx_requests_memory}
        limits:
          cpu: ${var.nginx_limits_cpu}
          memory: ${var.nginx_limits_memory}
      metrics:
        enabled: true
        serviceMonitor:
          enabled: true
      podAnnotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "10254"
      kind: Deployment
  YAML
  ]

  depends_on = [
    helm_release.karpenter
  ]
}

resource "kubectl_manifest" "target_binding_80" {
  yaml_body = <<YAML
apiVersion: elbv2.k8s.aws/v1beta1
kind: TargetGroupBinding
metadata:
  name: ingress-nginx
  namespace: ingress-nginx
spec:
  serviceRef:
    name: ingress-nginx-controller
    port: 80
  targetGroupARN: ${aws_lb_target_group.main.arn}
  targetType: instance
YAML
  depends_on = [
    helm_release.nginx_controller
  ]
}