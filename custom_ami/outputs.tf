output "lighting_service_ami" {
  value = aws_ami_from_instance.lighting_service_ami.id
}

output "heating_service_ami" {
  value = aws_ami_from_instance.heating_service_ami.id
}

output "status_service_ami" {
  value = aws_ami_from_instance.status_ami.id
}

output "private_service_ami" {
  value = aws_ami_from_instance.auth_ami.id
}