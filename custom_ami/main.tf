locals {
  heating = jsondecode(file("${path.module}/service_heating.json"))
  lighting = jsondecode(file("${path.module}/service_lighting.json"))
  status = jsondecode(file("${path.module}/status.json"))
  auth = jsondecode(file("${path.module}/auth.json"))
}

resource "aws_ami_from_instance" "lighting_service_ami" {
name = "lighting"
source_instance_id = local.lighting.instance_id
}

resource "aws_ami_from_instance" "heating_service_ami" {
name = "heating"
source_instance_id = local.heating.instance_id
}

resource "aws_ami_from_instance" "status_ami" {
name = "status"
source_instance_id = local.status.instance_id
}

resource "aws_ami_from_instance" "auth_ami" {
name = "auth"
source_instance_id = local.auth.instance_id
}