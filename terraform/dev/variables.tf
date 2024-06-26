variable "region" {
  description = "AWS region"
  type = string
  
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type = string
  
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type = list(string)
  
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
  type = list(string)
  
}

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

variable "subnet_id" {
    description = "subnet_id"
    type = string
  
}

variable "public_subnet_ids" {
  description = "value"
  
}

variable "private_subnet_ids" {
  description = "value"
  
}
variable "availability_zone" {
  description = "availability_zone"
  type = list(string)
  
}

variable "vpc_id" {
  description = "vpc_id"
  type = string
}
variable "frontend_instance_sg" {
  description = "frontend_instance_sg"
  type = string
  
}
variable "backend_instance_sg" {
  description = "backend_instance_sg"
  type = string
  
}
variable "security_grp_frontend" {
  description = "security_grp_frontend"
  type = string
  
}
variable "security_grp_backend" {
  description = "security_grp_backend"
  type = string
  
}

variable "private_instance_ids" {
  description = "private_instance_ids"
  
}

variable "public_instance_ids" {
  description = "public_instance_ids"
  
}