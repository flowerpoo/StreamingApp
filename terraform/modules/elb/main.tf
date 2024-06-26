// for public subnet load balancer 
resource "aws_lb" "my_alb" {
  name               = "stream-alb-public"
  internal           = false
  load_balancer_type = "application"
  security_groups = [var.security_grp_frontend, var.security_grp_backend]
  subnets            = var.public_subnet_ids

}
// for public subnet target group
resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group-public"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
    port                = 3000
  }
}
# Attach EC2 instances to Target Group
resource "aws_lb_target_group_attachment" "public_instance_attachment" {
  count = length(var.public_instance_ids)
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = var.public_instance_ids[count.index]
  port             = 3000
}
# Create Listener for ALB
resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 3000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
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

}

resource "aws_lb_target_group" "my_target_group_private" {
  name     = "my-target-group-private"
  port     = 3002
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
    port                = 3002
  }
}
# Attach EC2 instances to Target Group
resource "aws_lb_target_group_attachment" "private_instance_attachment" {
  count = length(var.private_instance_ids)
  target_group_arn = aws_lb_target_group.my_target_group_private.arn
  target_id        = var.private_instance_ids[count.index]
  port             = 3002
}

resource "aws_lb_listener" "my_listener_private" {
  load_balancer_arn = aws_lb.my_alb_pri.arn
  port              = 3002
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group_private.arn
  }
}