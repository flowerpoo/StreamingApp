variable "frontend_instance_ami" {
  description = "AMI ID for the frontend instance"
  type = string
}

variable "backend_instance_ami" {
  description = "AMI ID for the backend instance"
  type = string
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type = string
}
variable "key_name" {
  description = "key name "
}


variable "public_subnet_ids" {
  description = "public_subnet_ids"
  
}
variable "private_subnet_ids" {
  description = "private_subnet_id"
  
}
variable "subnet_id" {
    description = "subnet_id"
  
}

variable "security_grp_frontend" {
  description = "value"
  
}
variable "security_grp_backend" {
  description = "value"
  
}