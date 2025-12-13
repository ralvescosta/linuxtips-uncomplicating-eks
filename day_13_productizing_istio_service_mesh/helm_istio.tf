resource "helm_release" "istio_base" {
  name             = "istio-base"
  chart            = "base"
  repository       = "https://istio-release.storage.googleapis.com/charts"
  namespace        = "istio-system"
  create_namespace = true

  version = var.istio_version

  depends_on = [
    aws_eks_cluster.main,
    helm_release.karpenter
  ]
}

resource "helm_release" "istiod" {
  name             = "istio"
  chart            = "istiod"
  repository       = "https://istio-release.storage.googleapis.com/charts"
  namespace        = "istio-system"
  create_namespace = true

  version = var.istio_version

  values = [<<-YAML
    sidecarInjectorWebhook:
      rewriteAppHTTPProbe: false
  YAML
  ]

  depends_on = [
    helm_release.istio_base
  ]
}

resource "helm_release" "istio_ingress" {
  name             = "istio-ingressgateway"
  chart            = "gateway"
  repository       = "https://istio-release.storage.googleapis.com/charts"
  namespace        = "istio-system"
  create_namespace = true

  version = var.istio_version

  values = [<<-YAML
    service:
      type: NodePort
    autoscaling:
      minReplicas: ${var.istio_gateway_autoscaling.min}
      maxReplicas: ${var.istio_gateway_autoscaling.max}
      targetCPUUtilizationPercentage: ${var.istio_gateway_autoscaling.target_cpu_percentage}
  YAML
  ]

  depends_on = [
    helm_release.istio_base,
    helm_release.istiod
  ]
}

resource "kubectl_manifest" "target_binding_80" {
  yaml_body = <<YAML
apiVersion: elbv2.k8s.aws/v1beta1
kind: TargetGroupBinding
metadata:
  name: istio-ingress
  namespace: istio-system
spec:
  serviceRef:
    name: istio-ingressgateway
    port: 80
  targetGroupARN: ${aws_lb_target_group.main.arn}
  targetType: instance
YAML

  depends_on = [
    helm_release.istio_ingress,
    aws_lb_target_group.main,
  ]
}