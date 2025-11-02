resource "aws_eks_node_group" "main" {
  cluster_name    = var.aws_eks_cluster_id
  node_group_name = format("%s-bottlerocket", var.aws_eks_cluster_id)
  node_role_arn   = var.aws_eks_nodes_role_arn
  instance_types  = var.nodes_instance_sizes

  subnet_ids = var.pod_subnet_ids

  scaling_config {
    desired_size = lookup(var.auto_scale_options, "desired")
    max_size     = lookup(var.auto_scale_options, "max")
    min_size     = lookup(var.auto_scale_options, "min")
  }

  capacity_type = "ON_DEMAND"
  ami_type      = "BOTTLEROCKET_x86_64"

  labels = {
    "capacity/os"   = "BOTTLEROCKET"
    "capacity/arch" = "x86_64"
    "capacity/type" = "ON_DEMAND"
  }

  tags = {
    "kubernetes.io/cluster/${var.project_name}" = "owned"
  }

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size
    ]
  }

  timeouts {
    create = "1h"
    update = "2h"
    delete = "2h"
  }
}