resource "aws_security_group" "allow_http" {
  vpc_id = var.vpc_id
  name   = "allow_inbound_traffic_http"

  dynamic "ingress" {
    for_each = var.ingress_http
    content {
      description = "Inbound HTTP traffic"
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}

resource "aws_security_group" "allow_https" {
  vpc_id = var.vpc_id
  name   = "allow_inbound_traffic_https"

  dynamic "ingress" {
    for_each = var.ingress_https
    content {
      description = "Inbound HTTP traffic"
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}



//outbound
resource "aws_security_group" "egress_traffic" {
  vpc_id = var.vpc_id
  name   = "allow_egress_traffic"

  dynamic "egress" {
    for_each = var.egress_traffic
    content {
      description = "Outbound traffic"
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}



//ssh
resource "aws_security_group" "allow_ssh" {
  name        = "allow ssh"
  description = "Allow shh inbound traffic"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "my_ip_adress_inbound" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [format("%s/%s", data.external.myip.result["internet_ip"], 32)]
  security_group_id = aws_security_group.allow_ssh.id
}

data "external" "myip" {
  program = ["/bin/bash", "${path.module}/script.sh"]
}

resource "aws_security_group_rule" "my_ip_adress_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_ssh.id
}

//for private instances

resource "aws_security_group" "private_ssh_traffic" {
  name        = "allow ssh for private"
  description = "Allow private SSH inbound traffic"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "private_ssh_ingress" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
  security_group_id        = aws_security_group.private_ssh_traffic.id
}


resource "aws_security_group_rule" "private_tcp" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private_ssh_traffic.id
}


resource "aws_security_group_rule" "private_ssh_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private_ssh_traffic.id
}


//bastion
resource "aws_security_group" "bastion" {
  name        = "bastion-security-group"
  description = "Security group for bastion host"

  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [format("%s/%s", data.external.myip.result["internet_ip"], 32)]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}







