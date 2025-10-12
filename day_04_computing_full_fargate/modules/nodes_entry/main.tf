resource "aws_eks_access_entry" "nodes" {
  cluster_name  = var.aws_eks_cluster_id
  principal_arn = var.eks_nodes_role_arn
  type          = "EC2_LINUX"
}