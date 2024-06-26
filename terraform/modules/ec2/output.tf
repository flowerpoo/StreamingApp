output "frontend_instance_ids" {
  value = aws_instance.frontend_instance[*].id
}

output "backend_instance_ids" {
  value = aws_instance.backend_instance[*].id
}
