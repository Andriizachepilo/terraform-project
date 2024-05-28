resource "aws_lb" "app_load_balancer" {
  name               = "Public-facing-ALB"
  internal           = false
  load_balancer_type = var.lb_type
  security_groups    = join(",", var.security_groups)
  subnets            = join(",", sort(var.public_subnets))

}

resource "aws_lb_listener" "public_facing_alb_listener" {
  load_balancer_arn = aws_lb.app_load_balancer.arn
  port              = var.alb_listener_protocol == "HTTP" ? 80 : 443
  protocol          = var.alb_listener_protocol
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Not found :("
      status_code  = "404"
    }
  }

  depends_on = [aws_lb_target_group.public_ALB_target_group]
}

resource "aws_lb_listener_rule" "dynamic_rules" {
  count        = length(var.alb_tg_name)
  listener_arn = aws_lb_listener.public_facing_alb_listener.arn

  action {
    type             = var.type
    target_group_arn = aws_lb_target_group.public_ALB_target_group[*].arn
  }
  condition {
    path_pattern {
      values = [var.path_pattern[count.index]]
    }
  }
}


resource "aws_lb_target_group" "public_ALB_target_group" {
  count    = length(var.alb_tg_name)
  name     = var.alb_tg_name[count.index]
  port     = var.alb_target_group_port
  protocol = var.alb_target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    path = var.instance_health_check_paths[count.index]
    port = var.alb_target_group_port[count.index]
  }
}


resource "aws_lb_target_group_attachment" "public_ALB_target_group_attachment" {
  count            = length(aws_lb_target_group.public_ALB_target_group[*].arn)
  target_group_arn = aws_lb_target_group.public_ALB_target_group[count.index].arn
  target_id        = var.targets_id[count.index]
}

#Internal load balancer

resource "aws_lb" "internal_load_balancer" {
  name            = "Internal-load-balancer"
  internal        = true
  security_groups = join(",", var.ilb_security_groups)
  subnets         = join(",", sort(var.private_subnets))

}

resource "aws_lb_listener" "internal_lb_listener" {
  load_balancer_arn = aws_lb.internal_load_balancer.arn
  port              = var.ilb_listener_protocol == "HTTP" ? 80 : 443
  protocol          = var.ilb_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal_target_group.arn
  }
  depends_on = [aws_lb_target_group.internal_target_group]

}



resource "aws_lb_target_group" "internal_target_group" {
  name     = "Internal-load-balancer-TG"
  port     = var.ilb_target_group_listener_port
  protocol = var.ilb_target_group_listener_protocol
  vpc_id   = var.vpc_id

  health_check {
    path = var.private_instance_health_check
    port = aws_lb_listener.internal_lb_listener.port
  }
}

resource "aws_lb_target_group_attachment" "internal_lb_target_group_attachment" {
  target_group_arn = aws_lb_target_group.internal_target_group.arn
  target_id        = var.target_private_instance
}






