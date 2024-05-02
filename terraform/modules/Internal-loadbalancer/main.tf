resource "aws_lb" "internal_load_balancer" {
  name            = "Internal-load-balancer"
  internal        = true
  security_groups = var.security_groups[*]
  subnets         = var.private_subnets[*]

}

resource "aws_lb_listener" "internal_lb_listener" {
  load_balancer_arn = aws_lb.internal_load_balancer.arn
  port              = var.ilb_listener_port
  protocol          = var.ilb_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}



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
