resource "aws_autoscaling_attachment" "public_attachment" {
  count                  = length(var.name_asg_public)
  autoscaling_group_name = var.name_asg_public[count.index]
  lb_target_group_arn    = var.public_target_group_arn[count.index]
}


resource "aws_autoscaling_attachment" "private_attachment" {
  autoscaling_group_name = var.name_asg_private
  lb_target_group_arn    = var.private_target_group_arn
}
