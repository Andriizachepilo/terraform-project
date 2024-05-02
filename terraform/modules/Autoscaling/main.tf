resource "aws_autoscaling_group" "asg_public" {
  count               = length(var.name_asg_public)
  name                = var.name_asg_public[count.index]
  max_size            = var.max_size[count.index]
  min_size            = var.min_size[count.index]
  desired_capacity    = var.desired_capacity[count.index]
  vpc_zone_identifier = var.subnets_for_autoscaling_group
  health_check_type   = var.health_check_type[count.index]

  launch_template {
    id      = var.public_launch_id[count.index]
    version = var.version_of_launch_template[count.index]
  }
}

resource "aws_autoscaling_group" "asg_private" {
  name                = var.name_asg_private
  max_size            = var.max_size_private
  min_size            = var.min_size_private
  desired_capacity    = var.desired_capacity_private
  vpc_zone_identifier = var.subnets_for_autoscaling_group_private
  health_check_type   = var.health_check_type_private


  launch_template {
    id      = var.private_launch_id
    version = var.version_of_launch_template_private
  }
}

resource "aws_autoscaling_attachment" "public_attachment" {
  count                  = length(var.name_asg_public)
  autoscaling_group_name = var.name_asg_public[count.index]
  lb_target_group_arn    = var.public_target_group_arn[count.index]
}


resource "aws_autoscaling_attachment" "private_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg_private.name
  lb_target_group_arn    = var.private_target_group_arn
}
