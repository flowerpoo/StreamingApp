output "elb_dns_name_public" {
  value = aws_lb.my_alb.dns_name
}

output "elb_dns_name_private" {
  value = aws_lb.my_alb_pri.dns_name
}