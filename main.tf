# Security Group

resource "aws_security_group" "this" {
  vpc_id = var.vpc.id

  name        = "lb-${var.name}"
  description = "LB: ${var.name}"

  tags = merge({
    Name = "LB: ${var.name}"
  }, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "ingress" {
  for_each = var.ingress_security_groups

  security_group_id = aws_security_group.this.id

  type                     = "ingress"
  source_security_group_id = each.value.id
  protocol                 = "tcp"
  from_port                = var.ingress_port
  to_port                  = var.ingress_port

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

  internal        = true
  subnets         = var.subnets[*].id
  security_groups = [aws_security_group.this.id]

  tags = var.tags
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
