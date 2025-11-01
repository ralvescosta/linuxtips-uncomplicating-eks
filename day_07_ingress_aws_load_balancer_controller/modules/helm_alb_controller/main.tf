resource "helm_release" "alb_ingress_controller" {
  name             = "aws-load-balancer-controller"
  repository       = "https://aws.github.io/eks-charts"
  chart            = "aws-load-balancer-controller"
  namespace        = "kube-system"
  create_namespace = true

  wait    = true
  replace = true

  values = [<<-YAML
    clusterName: ${var.project_name}
    region: ${var.region}
    vpcId: ${var.vpc_id}
    serviceAccount:
      create: false
      name: aws-load-balancer-controller
      annotations:
        eks.amazonaws.com/role-arn: ${var.alb_controller_role_arn}
  YAML
  ]
}