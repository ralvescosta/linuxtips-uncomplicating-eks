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
        type: NodePort
        internal:
          enabled: true
      publishService:
        enabled: true
      resources:
        requests:
          cpu: 250m
          memory: 512Mi
        limits:
          cpu: 500m
          memory: 1024Mi
      autoscaling:
        enabled: true
        minReplicas: 3
        maxReplicas: 30
  YAML
  ]
}

resource "kubectl_manifest" "target_binding_80" {
  yaml_body = <<-YAML
apiVersion: albv2.k8s.aws/v1beta1
kind: TargetGroupBinding
metadata:
  name: ingress-nginx
  namespace: ingress-nginx
spec:
  targetGroupARN: ${var.alb_target_group_arn}
  targetType: instance
  serviceRef:
    name: ingress-nginx-controller
    port: 80
YAML

 depends_on = [helm_release.nginx_controller]
}