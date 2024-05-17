provider "aws" {
    region = "us-east-1"
  
}

# Define EC2 instance
resource "aws_instance" "streaming_frontend" {
  ami  = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [var.aws_security_group]
  tags = {
    Name = "streaming_frontend"
  }
 
}

resource "aws_instance" "streaming_backend" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [var.aws_security_group]
  tags = {
    Name = "streaming_backend"
  }
}
  

resource "null_resource" "local01" {
    triggers = {
      mytest=timestamp()
    }

    provisioner "local-exec" {
        command = <<-EOF
        /bin/echo "[frontend]" > inventory
        /bin/echo "${aws_instance.streaming_frontend.tags.Name} ansible_host=${aws_instance.streaming_frontend.public_ip} ansible_user=ubuntu"  >> inventory
        /bin/echo "[backend]" >> inventory
        /bin/echo "${aws_instance.streaming_backend.tags.Name} ansible_host=${aws_instance.streaming_backend.public_ip} ansible_user=ubuntu" >> inventory
        EOF
      
    }
    provisioner "local-exec" {
      command = <<-EOF
      /bin/echo "export let vediosource="http://${aws_instance.streaming_backend.public_ip}:3002/streaming"" > url.js
      EOF
      
    }

    depends_on = [ aws_instance.streaming_frontend,aws_instance.streaming_backend]
  
}
