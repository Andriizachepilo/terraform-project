# # Bastion Security Group
# resource "aws_security_group" "bastion_security_group" {
#   name        = "bastion-sg"
#   description = "Security group for bastion host"
#   vpc_id      = var.vpc_id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = [format("%s/%s", data.external.myip.result["internet_ip"], 32)]
#   }
# }

# #Private instance Security Group
# resource "aws_security_group" "private_instance_sg" {
#   name   = "private-sg"
#   vpc_id = var.vpc_id


#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

# }


# resource "aws_security_group" "public_instances_sg" {
#   ingress = {
#     from_port  = 80
#     to_port    = 443
#     protocol   = "tcp"
#     cidr_block = ["0.0.0.0/0"]
#   }

#   egress = {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }





# # Public Instances Security Group
# resource "aws_security_group" "public_security_group" {
#   name        = "public-sg"
#   description = "Security group for public EC2 instances "
#   vpc_id      = var.vpc_id


#   ingress {
#     from_port       = 22
#     to_port         = 22
#     protocol        = "tcp"
#     security_groups = [aws_security_group.bastion_security_group.id]
#   }


#   ingress {
#     from_port       = 80
#     to_port         = 443
#     protocol        = "tcp"
#     security_groups = [aws_security_group.bastion_security_group.id]
#   }
# }

# # Private Instances Security Group
# resource "aws_security_group" "private_security_group" {
#   name        = "private-sg"
#   description = "Security group for private EC2 instance"
#   vpc_id      = var.vpc_id


#   ingress {
#     from_port       = 22
#     to_port         = 22
#     protocol        = "tcp"
#     security_groups = [aws_security_group.bastion_security_group.id]
#   }


#   ingress {
#     from_port       = 80
#     to_port         = 443
#     protocol        = "tcp"
#     security_groups = [aws_security_group.bastion_security_group.id]
#   }
# }



data "external" "myip" {

program = ["bash", "${path.module}/script.sh"]

}

# Bastion Host Security Group
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Security group for bastion host"
  vpc_id      = var.vpc_id

 
ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [format("%s/%s", data.external.myip.result["internet_ip"], 32)] 
  }

 
  egress {
    from_port   = 80
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Public Instances Security Group
resource "aws_security_group" "public_sg" {
  name        = "public-security-groups"
  description = "Security group for public EC2 instances"
  vpc_id      = var.vpc_id


  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastion_sg.id]
  }

  ingress {
    from_port        = 80
    to_port          = 443
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastion_sg.id]
  }

}

# Private Instances Security Group
resource "aws_security_group" "private_sg" {
  name        = "private-security-groups"
  description = "Security group for private EC2 instance"
  vpc_id      = var.vpc_id

 
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastion_sg.id]
  }

 
  ingress {
    from_port        = 80
    to_port          = 443
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastion_sg.id]
  }
  
}