output "public_instance_ids" {
  value = [for instance in
    [
      aws_instance.service_lighting,
      aws_instance.service_heating,
      aws_instance.status
    ] :
    instance.id if contains(var.public_subnets, instance.subnet_id)
  ]
}





output "private_instance_id" {
  value = aws_instance.auth.id
}
