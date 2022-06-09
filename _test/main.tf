provider "aws" {
  region = "local"
}

module "alb" {
  source  = "./.."

  name = "example"

  vpc = { id = "vpc-12345678" }

  subnets = [
    { id = "subnet-01234567" },
    { id = "subnet-12345678" },
  ]

  ingress_security_groups = {
    some-service = { id = "sg-12345678" }
  }

  target_group = { arn = "arn:aws:elasticloadbalancing:local:123456789012:targetgroup/some-service/0123456789abcdef" }

  tags = {
    app  = "some-service"
    env  = "production"
  }
}
