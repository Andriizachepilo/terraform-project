output "launch_template_for_public_services" {
  value = aws_launch_template.launch_template_for_public_services[*].id
}

output "launch_template_for_private_service" {
  value = aws_launch_template.launch_template_for_private_service.id
}