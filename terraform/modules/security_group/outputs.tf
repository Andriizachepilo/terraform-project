output "security_group_private_instances" {
  value = aws_security_group.private_ssh_inbound.id
}

output "security_group_ids" {
  value = [
    aws_security_group.allow_http.id,
    aws_security_group.allow_https.id,
    aws_security_group.egress_traffic.id,
    aws_security_group.allow_ssh.id
  ]
}

output "bastion_SG" {
  value = aws_security_group.bastion.id
}