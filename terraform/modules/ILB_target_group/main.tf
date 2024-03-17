resource "aws_lb_target_group" "internal_target_group" {
  name     = "Internal-load-balancer-TG"
  port     = var.ilb_target_group_listener_port
  protocol = var.ilb_target_group_listener_protocol
  vpc_id   = var.vpc_id

  health_check {
    path = var.private_instance_health_check
    port = var.ilb_target_group_listener_port
  }
}

resource "aws_lb_target_group_attachment" "public_ALB_target_group_attachment" {
  target_group_arn = aws_lb_target_group.internal_target_group.arn
  target_id        = var.target_private_instance
}
