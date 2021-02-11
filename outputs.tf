output "security_group" {
  description = "Security group used by the ALB"
  value       = aws_security_group.this
}

output "this" {
  description = "ALB"
  value       = aws_lb.this
}
