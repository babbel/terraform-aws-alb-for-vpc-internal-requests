# Application Load Balancer (ALB) for VPC-Internal Requests

This module creates a private ALB, a default ALB listener (with HTTP protocol), and a security group for service-2-service requests within a VPC.

## Example Usage

```tf
module "alb" {
  source  = "babbel/alb-for-vpc-internal-requests/aws"
  version = "~> 1.1"

  name = "example"

  vpc     = aws_vpc.this
  subnets = [aws_subnet.private_a, aws_subnet.private_b]

  ingress_security_groups = {
    some-service = aws_security_group.some_service
  }

  target_group = aws_lb_target_group.example

  tags = {
    app = "example"
    env = "production"
  }
}
```
