resource "helm_release" "node_termination_handler" {
  name      = "aws-node-termination-handler"
  namespace = "kube-system"

  chart      = "aws-node-termination-handler"
  repository = "https://aws.github.io/eks-charts/"

  set = [
    {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = var.node_termination_role_arn
    },
    {
      name  = "awsRegion"
      value = var.region
    },
    {
      name  = "queueURL"
      value = var.sqs_queue_url
    },
    {
      name  = "enableSqsTerminationDraining"
      value = true
    },
    {
      name  = "enableSpotInterruptionDraining"
      value = true
    },
    {
      name  = "enableRebalanceMonitoring"
      value = true
    },

    {
      name  = "enableRebalanceDraining"
      value = true
    },

    {
      name  = "enableScheduledEventDraining"
      value = true
    },
    {
      name  = "deleteSqsMsgIfNodeNotFound"
      value = true
    },
    {
      name  = "checkTagBeforeDraining"
      value = false
    }
  ] 
}