data "aws_iam_policy_document" "cluster" {

  version = "2012-10-17"

  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]
    effect = "Allow"

    principals {
      type = "Federated"
      identifiers = [
        var.openid_connect_provider_arn,
      ]
    }
  }

}

resource "aws_iam_role" "autoscaler" {
  name               = format("%s-cluster-autoscaler", var.project_name)
  assume_role_policy = data.aws_iam_policy_document.cluster.json
}

data "aws_iam_policy_document" "autoscaler_policy" {
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "autoscaling-plans:DescribeScalingPlans",
      "autoscaling-plans:GetScalingPlanResourceForecastData",
      "autoscaling-plans:DescribeScalingPlanResources",
      "autoscaling:DescribeAutoScalingNotificationTypes",
      "autoscaling:DescribeLifecycleHookTypes",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeTerminationPolicyTypes",
      "autoscaling:DescribeScalingProcessTypes",
      "autoscaling:DescribePolicies",
      "autoscaling:DescribeTags",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeMetricCollectionTypes",
      "autoscaling:DescribeLoadBalancers",
      "autoscaling:DescribeLifecycleHooks",
      "autoscaling:DescribeAdjustmentTypes",
      "autoscaling:DescribeScalingActivities",
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAccountLimits",
      "autoscaling:DescribeScheduledActions",
      "autoscaling:DescribeLoadBalancerTargetGroups",
      "autoscaling:DescribeNotificationConfigurations",
      "autoscaling:DescribeInstanceRefreshes",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "ec2:DescribeLaunchTemplateVersions"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "autoscaler" {
  name   = format("%s-cluster-autoscaler", var.project_name)
  path   = "/"
  policy = data.aws_iam_policy_document.autoscaler_policy.json
}

resource "aws_iam_policy_attachment" "autoscaler" {
  name = format("%s-cluster-autoscaler", var.project_name)

  roles = [
    aws_iam_role.autoscaler.name
  ]

  policy_arn = aws_iam_policy.autoscaler.arn
}