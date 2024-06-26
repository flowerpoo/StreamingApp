variable "public_subnet_ids" {
  description = "public_subnet_ids"
  
}
variable "private_subnet_ids" {
  description = "private_subnet_ids"
  
}

variable "security_grp_frontend" {
  description = "value"
  
}
variable "security_grp_backend" {
  description = "value"
  
}
variable "vpc_id" {
  description = "vpc_id"
  type = string
}

variable "private_instance_ids" {
  description = "private_instance_ids"
  
}

variable "public_instance_ids" {
  description = "public_instance_ids"
  
}