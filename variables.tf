variable "ingress_port" {
  description = "The port the ALB will listen to"

  type    = number
  default = 80
}

variable "ingress_security_groups" {
  description = "Map of security groups the ALB will receive requests from"

  type = map(
    object({
      id = string
    })
  )

  default = {}
}

variable "name" {
  description = "Name of the ALB"

  type = string
}

variable "subnets" {
  description = "List of subnets the ALB will be created in"

  type = list(
    object({
      id = string
    })
  )
}

variable "tags" {
  description = "Map of tags to assign to all resources supporting tags (in addition to the `Name` tag)"

  type = map(string)
}

variable "target_group" {
  description = "Target group all requests to the ALB will be forwarded to"

  type = object({
    arn = string
  })
}

variable "vpc" {
  description = "VPC the ALB and the security group will be created in"

  type = object({
    id = string
  })
}
