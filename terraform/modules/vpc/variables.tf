variable "region" {
    description = "AWS region"
  
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type = list(string)
  
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
  type = list(string)
  
}
variable "availability_zone" {
  description = "availability_zone"
  type = list(string)
  
}

