variable "drop_invalid_header_fields" {
  type    = bool
  default = true

  description = <<EOS
Specify if the ALB should drop invalid header fields.
EOS
}

variable "ingress_port" {
  type    = number
  default = 80

  description = <<EOS
The port the ALB will listen to.
EOS
}

variable "name" {
  type = string

  description = <<EOS
Name of the ALB.
EOS
}

variable "subnets" {
  type = list(
    object({
      id = string
    })
  )

  description = <<EOS
List of subnets the ALB will be created in.
EOS
}

variable "tags" {
  type    = map(string)
  default = {}

  description = <<EOS
Map of tags assigned to all AWS resources created by this module.
EOS
}

variable "target_group" {
  type = object({
    arn = string
  })

  description = <<EOS
Target group all requests to the ALB will be forwarded to.
EOS
}

variable "vpc" {
  type = object({
    id = string
  })

  description = <<EOS
VPC the ALB and the security group will be created in.
EOS
}
