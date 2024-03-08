resource "aws_lb" "internal_load_balancer" {
  name               = "Internal-load-balancer"
  internal           = true
  security_groups    = var.security_groups[*]
  subnets            = var.private_subnets[*]
  
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