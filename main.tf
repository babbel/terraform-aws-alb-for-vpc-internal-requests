# Security Group

resource "aws_security_group" "this" {
  vpc_id = var.vpc.id

  name        = "lb-${var.name}"
  description = "LB: ${var.name}"

  tags = merge({
    Name = "LB: ${var.name}"
  }, var.default_tags, var.security_group_tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.this.id

  type        = "egress"
  cidr_blocks = ["0.0.0.0/0"]
  protocol    = "-1"
  from_port   = 0
  to_port     = 0

  lifecycle {
    create_before_destroy = true
  }
}

# ALB

resource "aws_lb" "this" {
  name = var.name

  load_balancer_type = "application"

  drop_invalid_header_fields = var.drop_invalid_header_fields

  internal        = true
  subnets         = var.subnets[*].id
  security_groups = [aws_security_group.this.id]

  tags = merge(var.default_tags, var.lb_tags)
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn

  protocol = "HTTP"
  port     = var.ingress_port

  default_action {
    target_group_arn = var.target_group.arn
    type             = "forward"
  }
}
