# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"

}

resource "aws_nat_gateway" "NAT" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = var.public_subnet_id

     tags = {
     Name = "NAT Gateway"
     }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT.id
  }
  tags = {
    Name = "private-route-table"
  }
}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private_subnet_asso" {
  count = length(var.private_subnet_id)
  subnet_id      = var.private_subnet_id[count.index]
  route_table_id = aws_route_table.private_route_table.id
}