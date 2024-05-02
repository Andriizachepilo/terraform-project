data "external" "myip" {

  program = ["bash", "${path.module}/script.sh"]

}

# Bastion Host Security Group
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Security group for bastion host"
  vpc_id      = var.vpc_id

#allow ingress only from my ip into the bastion instance
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [format("%s/%s", data.external.myip.result["internet_ip"], 32)]
  }

  #allow egress to ssh to the instances
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "public_instance_sg" {
  vpc_id = var.vpc_id


  #allow ssh from bastion instance 
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }


  #allow http and https traffic only from the load balancer 
  ingress {
    from_port       = 3000
    to_port         = 3003
    protocol        = "tcp"
    security_groups = [aws_security_group.load_balancer_sg.id]
  }

  #allow all egress for "git clone " and "docker pull"
  egress = {
    from_port  = 0
    to_port    = 65535
    protocol   = "tcp"
    cidr_block = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "private_instance_sg" {
  vpc_id = var.vpc_id

  #allow ingress only from the internal load balancer
  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.internal_lb_sg.id]
  }

  #allow ssh from bastion instance
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]

  }

  #allow all egress for "git clone" and "docker pull"
  egress = {
    from_port  = 0
    to_port    = 65535
    protocol   = "tcp"
    cidr_block = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "load_balancer_sg" {
  vpc_id = var.vpc_id

#allow all ingress traffic to the public load balancer
  ingress = {
    from_port  = 80
    to_port    = 443
    protocol   = "tcp"
    cidr_block = ["0.0.0.0/0"]

  }

}

#allow ingress traffic only from the public load balancer
resource "aws_security_group" "internal_lb_sg" {
  vpc_id = var.vpc_id

  ingress = {
    from_port       = 80
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.load_balancer_sg.id]
  }

}

