variable "vpc_id" {
  description = "created vpc id defined here"
  type        = string
}

variable "frontend_instance_sg" {
    description = "frontend_instance_sg name "
    type = string
  
}
variable "backend_instance_sg" {
    description = "backend_instance_sg"
    type = string
  
}