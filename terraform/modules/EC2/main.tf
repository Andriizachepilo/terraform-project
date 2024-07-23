data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}


resource "aws_instance" "service_lighting" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnets[2]
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name

  associate_public_ip_address = true

  tags = {
    Name = "service_lighting"
  }

  provisioner "remote-exec" {
    inline = [ 
      "git clone https://github.com/Andriizachepilo/terraform-project/tree/main/services-example/lights"
     ]
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/.ssh/my-key-pair.pem")
    host = self.public_ip
  }
}

resource "aws_instance" "service_heating" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnets[1]
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name

  associate_public_ip_address = true
  
  tags = {
    Name = "service_heating"
  }

  provisioner "remote-exec" {
    inline = [ 
      "git clone https://github.com/Andriizachepilo/terraform-project/tree/main/services-example/heating"
     ]
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/.ssh/my-key-pair.pem")
    host = self.public_ip
  }
}

resource "aws_instance" "status" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnets[0]
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = true
  key_name                    = var.key_name
  
  tags = {
    Name = "status"
  }

  provisioner "remote-exec" {
    inline = [ 
      "git clone https://github.com/Andriizachepilo/terraform-project/tree/main/services-example/status"
     ]
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/.ssh/my-key-pair.pem")
    host = self.public_ip
  }
}

resource "aws_instance" "auth" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnets[0]
  vpc_security_group_ids = var.security_group_ids_private_ec2
  key_name               = var.key_name

  tags = {
    Name = "auth"
  }
  
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnets[1]
  vpc_security_group_ids      = var.bastion_SG
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "bastion"
  }
}
