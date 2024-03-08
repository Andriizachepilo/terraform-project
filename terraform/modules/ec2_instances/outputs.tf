output "public_instance_ids" {
  value = [for instance in
    [
      aws_instance.service_lighting,
      aws_instance.service_heating,
      aws_instance.status
    ] :
    instance.id if instance.subnet_id == var.public_subnets[0]
  ]
}


output "private_instance_id" {
  value = aws_instance.auth.id
}
