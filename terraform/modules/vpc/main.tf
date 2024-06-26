resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  instance_tenancy = "default"

  tags = {
    Name = "StreamVPC"
  }
}

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidr_block)
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.public_subnet_cidr_block, count.index)
  availability_zone = element(var.availability_zone,count.index)

  tags = {
    Name = "Public-Subnet-${count.index +1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_cidr_block)
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.private_subnet_cidr_block, count.index)
  availability_zone = element(var.availability_zone,count.index)

  tags = {
    Name = "Private-subnet-${count.index +1}"
  }
}


