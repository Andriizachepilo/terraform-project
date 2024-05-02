output "bastion_sg" {
  value = aws_security_group.bastion_sg.id
}

output "ec2_public_sg" {
  value = aws_security_group.public_instance_sg.id
}

output "ec2_private_sg" {
  value = aws_security_group.private_instance_sg.id
}

output "public_lb_sg" {
  value = aws_security_group.load_balancer_sg.id
}

output "internal_lb_sg" {
  value = aws_security_group.internal_lb_sg.id
}