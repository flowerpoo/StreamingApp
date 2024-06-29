// for public subnet load balancer 
resource "aws_lb" "my_alb" {
  name               = "stream-alb-public"
  internal           = false
  load_balancer_type = "application"
  security_groups = [var.security_grp_frontend, var.security_grp_backend]
  subnets            = var.public_subnet_ids
  tags = {
    Name = "my_alb"
  }

}
// for public subnet target group
resource "aws_lb_target_group" "public_target_group" {
  name   = "public-target-group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
  tags = {
    Name = "public-target-group"
  }

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
    port                = 3000
  }
}

# Create Listener for ALB
resource "aws_lb_listener" "public_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 3000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_target_group.arn
  }
}
# Attach EC2 instances to Target Group
resource "aws_lb_target_group_attachment" "public_instance_attachment" {
  count = length(var.public_instance_ids)
  target_group_arn = aws_lb_target_group.public_target_group.arn
  target_id        = var.public_instance_ids[count.index]
  port             = 3000
  
}

// Attach target group to ALB
resource "aws_lb_listener_rule" "public_listener_rule" {
  listener_arn = aws_lb_listener.public_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_target_group.arn
  }

  // Match all incoming traffic
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}


 ###########################################################
// for privare subnet load balancer 
resource "aws_lb" "my_alb_pri" {
  name               = "stream-alb-private"
  internal           = false
  load_balancer_type = "application"
  security_groups = [var.security_grp_frontend, var.security_grp_backend]
  subnets            = var.private_subnet_ids
   tags = {
    Name = "my_alb_pri"
  }

}

resource "aws_lb_target_group" "private_target_group" {
  name     = "private-target-group"
  port     = 3002
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
  tags = {
    Name = "private-target-group"
  }
  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
    port                = 3002
  }
}

# listener
resource "aws_lb_listener" "private_listener" {
  load_balancer_arn = aws_lb.my_alb_pri.arn
  port              = 3002
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_target_group.arn
  }
}
# Attach EC2 instances to Target Group
resource "aws_lb_target_group_attachment" "private_instance_attachment" {
  count = length(var.private_instance_ids)
  target_group_arn = aws_lb_target_group.private_target_group.arn
  target_id        = var.private_instance_ids[count.index]
  port             = 3002
}

// Attach target group to ALB
resource "aws_lb_listener_rule" "private_listener_rule" {
  listener_arn = aws_lb_listener.private_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_target_group.arn
  }

  // Match all incoming traffic
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
