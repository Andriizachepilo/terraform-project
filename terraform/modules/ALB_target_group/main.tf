resource "aws_lb_target_group" "public_ALB_target_group" {
  count = var.instance_count
  name     = "Public-load-balancer${count.index + 1}"
  port     = var.alb_target_group_port
  protocol = var.alb_target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    path = var.instance_health_check_paths[count.index]
    port = var.alb_target_group_port
  }
}

#I spent ages thinking how I can make this code more dynamic, I tried to create it by using another "dynamic" template, but in that case I'm not able to assign ---
#targets id in my main module, either hardcoding target ID in .tfvars and have problems extracting 3 ARNs or using this way(the code you can see)
#since TF can not predict how many instances we will I created variable "count" which i'm not happy with, and .tfvars look very bad if we change sequence in any of those
#variables it will destroy the logic of the code, we need to follow strict sequence of adding values

resource "aws_lb_target_group_attachment" "public_ALB_target_group_attachment" {
  count = var.instance_count
  target_group_arn = aws_lb_target_group.public_ALB_target_group[count.index].arn
  target_id        = var.targets_id[count.index]
}











# resource "aws_lb_target_group_attachment" "public_ALB_target_group_attachment0" {
#   target_group_arn = aws_lb_target_group.public_ALB_target_group.arn
#   target_id        = var.targets_id[0]
#  }

# resource "aws_lb_target_group_attachment" "public_ALB_target_group_attachment1" {
#   target_group_arn = aws_lb_target_group.public_ALB_target_group.arn
#   target_id        = var.targets_id[1]
#  }

# resource "aws_lb_target_group_attachment" "public_ALB_target_group_attachment2" {
#   target_group_arn = aws_lb_target_group.public_ALB_target_group.arn
#   target_id        = var.targets_id[2]
#  }
