resource "helm_release" "kube_state_metrics" {
  name             = "kube-state-metrics"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-state-metrics"
  namespace        = "kube-system"
  create_namespace = true

  values = [
    yamlencode({
      apiService = {
        create = true
      }
      nodeSelector = {
        "karpenter.sh/nodepool" = "system"
      }
      tolerations = [
        {
          key      = "CriticalAddonsOnly"
          operator = "Exists"
        }
      ]
      metricLabelsAllowlist      = ["nodes=[*]"]
      metricAnnotationsAllowList = ["nodes=[*]"]
    })
  ]

  depends_on = [
    aws_eks_cluster.main
  ]
}