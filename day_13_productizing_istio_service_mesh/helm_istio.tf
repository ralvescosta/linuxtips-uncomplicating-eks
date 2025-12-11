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
  YAML
  ]

  depends_on = [
    helm_release.istio_base,
    helm_release.istiod
  ]
}