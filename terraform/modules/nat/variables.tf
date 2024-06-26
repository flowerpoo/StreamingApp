variable "vpc_id" {
  description = "created vpc id defined here"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type = list(string)
  
}

variable "private_subnet_id" {
    description = "private subnet id "
  
}
variable "public_subnet_id" {
    description = "private subnet id "
  
}