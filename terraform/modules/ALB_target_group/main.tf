resource "aws_lb_target_group" "public_ALB_target_group" {
  count    = length(var.alb_tg_name)
  name     = var.alb_tg_name[count.index]
  port     = var.alb_target_group_port[count.index]
  protocol = var.alb_target_group_protocol[count.index]
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









