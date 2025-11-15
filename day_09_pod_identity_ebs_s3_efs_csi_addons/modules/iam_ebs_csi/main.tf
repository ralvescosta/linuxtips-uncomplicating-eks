data "aws_iam_policy_document" "ebs_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}


resource "aws_iam_role" "ebs_role" {
  assume_role_policy = data.aws_iam_policy_document.ebs_role.json
  name               = format("%s-ebs-csi-role", var.project_name)
}

resource "aws_iam_role_policy_attachment" "ebs_role_attachment" {
  role       = aws_iam_role.ebs_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

resource "aws_eks_pod_identity_association" "ebs_csi_association" {
  cluster_name    = var.cluster_name
  namespace       = "kube-system"
  service_account = "ebs-csi-controller-sa"
  role_arn        = aws_iam_role.ebs_role.arn
}