# Bastion Security Group
resource "aws_security_group" "bastion_security_group" {
  name        = "bastion-sg-new"
  description = "Security group for bastion host"
  vpc_id      = var.vpc_id

  // allows SSH inbound from your IP address
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [format("%s/%s", data.external.myip.result["internet_ip"], 32)]
  }

  // allows outbound traffic to the internet on ports 80 (HTTP) and 443 (HTTPS)
  egress {
    from_port   = 80
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Public Instances Security Group
resource "aws_security_group" "public_security_group" {
  name        = "public-sg-new"
  description = "Security group for public EC2 instances "
  vpc_id      = var.vpc_id

  // allows SSH inbound from the bastion host
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastion_security_group.id]
  }

  // allows inbound HTTP and HTTPS traffic from the bastion host
  ingress {
    from_port        = 80
    to_port          = 443
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastion_security_group.id]
  }
}

# Private Instances Security Group
resource "aws_security_group" "private_security_group" {
  name        = "private-sg-new"
  description = "Security group for private EC2 instances (modified)"
  vpc_id      = var.vpc_id

  // allows SSH inbound from the bastion host's security group
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastion_security_group.id]
  }

  // allows inbound HTTP and HTTPS traffic from the bastion host
  ingress {
    from_port        = 80
    to_port          = 443
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastion_security_group.id]
  }
}
