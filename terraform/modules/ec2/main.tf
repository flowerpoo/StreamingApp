resource "aws_instance" "frontend_instance" {
  count = 2
  ami           = var.frontend_instance_ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id     = var.public_subnet_ids[count.index]
  security_groups = [var.security_grp_frontend]
  associate_public_ip_address = true

  // Additional configuration as needed

  tags = {
    Name = "FrontendInstance-${count.index}"
    Group_Name = "poo,garima,praj,nikil,pavan"
  }
}

resource "aws_instance" "backend_instance" {
  count         = 2
  ami           = var.backend_instance_ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id     = var.private_subnet_ids[count.index]
  security_groups = [var.security_grp_backend]

  // Additional configuration as needed

  tags = {
    Name = "BackendInstance-${count.index}"
  }
}

