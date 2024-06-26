# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
 // domain = "vpc"

}

resource "aws_nat_gateway" "NAT" {
    allocation_id = aws_eip.nat.id
    subnet_id = var.public_subnet_id

     tags = {
     Name = "NAT Gateway"
     }
}

resource "aws_route_table" "private" {
    depends_on = [ aws_nat_gateway.NAT ]
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT.id
  }
}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_id)
  subnet_id      = var.private_subnet_id[count.index]
  route_table_id = aws_route_table.private.id
}