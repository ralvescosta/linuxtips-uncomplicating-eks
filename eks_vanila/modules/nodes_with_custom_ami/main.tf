resource "aws_launch_template" "custom" {
  name = var.project_name

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 50
      volume_type = "gp3"
    }
  }

  ebs_optimized = true
  monitoring {
    enabled = false
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = format("%s-custom", var.project_name)
    }
  }

  user_data = base64encode(templatefile("${path.module}/ami/user-data.tpl", {
    CLUSTER_NAME                     = var.aws_eks_cluster_id
    KUBERNETES_ENDPOINT              = var.aws_eks_cluster_endpoint
    KUBERNETES_CERTIFICATE_AUTHORITY = var.aws_eks_cluster_certificate_authority
  }))
}

resource "aws_eks_node_group" "main" {
  cluster_name    = var.aws_eks_cluster_id
  node_group_name = format("%s-custom", var.aws_eks_cluster_id)
  node_role_arn   = var.aws_eks_nodes_role_arn
  instance_types  = var.nodes_instance_sizes

  subnet_ids = var.pod_subnet_ids

  scaling_config {
    desired_size = lookup(var.auto_scale_options, "desired")
    max_size     = lookup(var.auto_scale_options, "max")
    min_size     = lookup(var.auto_scale_options, "min")
  }

  launch_template {
    id      = aws_launch_template.custom.id
    version = aws_launch_template.custom.latest_version
  }

  capacity_type = "ON_DEMAND"

  labels = {
    "capacity/os"   = "AMAZON_LINUX"
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

  depends_on = [
    aws_launch_template.custom
  ]
}