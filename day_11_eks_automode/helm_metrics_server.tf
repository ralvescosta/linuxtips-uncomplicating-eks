resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metrics-server"
  namespace  = "kube-system"

  wait = false

  version = "7.2.16"

  values = [
    yamlencode({
      nodeSelector = {
        "karpenter.sh/nodepool" = "system"
      }
      tolerations = [
        {
          key      = "CriticalAddonsOnly"
          operator = "Exists"
        }
      ]
      apiService = {
        create = true
      }
    })
  ]

  depends_on = [
    aws_eks_cluster.main,
  ]
}