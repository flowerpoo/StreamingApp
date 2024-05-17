variable "ami" {
    description = "ami value for the instance"
    type    = string
    default = "ami-04b70fa74e45c3917"
  
}

variable "instance_type"{
    description = "instance type"
    type    = string
    default = "t3.micro"
}

variable "key_name"{
    description = "key name"
    default = "flower"
}

variable "aws_security_group"{
    description = "aws_security_group for connection"
    default = "poova"
}