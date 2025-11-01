resource "aws_lb" "ingress" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.subnet_ids

  enable_cross_zone_load_balancing = true

  tags = {
    "Name"                                      = "${var.project_name}-alb"
    "kubernetes.io/cluster/${var.project_name}" = "owned"
  }
}

resource "aws_lb_target_group" "main" {
  name     = "${var.project_name}-tg"
  port     = 8080
  protocol = "TCP"
  vpc_id   = var.vpc_id

  tags = {
    "Name"                                      = "${var.project_name}-tg"
    "kubernetes.io/cluster/${var.project_name}" = "owned"
  }
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.ingress.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

}