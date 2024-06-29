resource "aws_internet_gateway" "gw" {
 vpc_id = var.vpc_id
 
 tags = {
   Name = "Project stream IG"
 }
}

resource "aws_route_table" "public_route_table" {
 vpc_id = var.vpc_id

 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.gw.id
 }
 
 tags = {
   Name = "public_route_table"
 }
}

resource "aws_route_table_association" "public_subnet_asso" {
 count = length(var.public_subnet_id)
 subnet_id      = var.public_subnet_id[count.index]
 route_table_id = aws_route_table.public_route_table.id
}