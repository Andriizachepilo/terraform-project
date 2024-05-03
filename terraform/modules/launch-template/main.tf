resource "aws_launch_template" "launch_template_for_public_services" {
  count         = length(var.template_name)
  name          = var.template_name[count.index]
  image_id      = var.image_id[count.index]
  instance_type = var.instance_type
  key_name      = var.key_name


  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = var.public_subnet_id
    security_groups             = var.vpc_security_group_ids
  }
}


resource "aws_launch_template" "launch_template_for_private_service" {
  name          = var.template_name_private
  image_id      = var.private_image_id
  instance_type = var.instance_type
  key_name      = var.key_name


  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = var.private_subnet_id
    security_groups             = var.private_security_group

  }
}
