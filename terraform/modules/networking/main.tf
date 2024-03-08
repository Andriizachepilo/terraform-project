resource "aws_vpc" "project_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  
  tags = {
    Name = "project-vpc"
  }

}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.project_vpc.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = var.public_subnets[count.index]

  tags = {
    Name = "Public subnet ${count.index + 1}"
  }

}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.project_vpc.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = var.private_subnets[count.index]
 tags = {
    Name = "Private subnet ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.project_vpc.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
}

resource "aws_route_table_association" "public_association" {
  count          = length(aws_subnet.public_subnets[*])
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnets[count.index].id
}

resource "aws_eip" "eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "NAT_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnets[0].id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_gateway.id
  }
}

resource "aws_route_table_association" "private_association" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id 
}