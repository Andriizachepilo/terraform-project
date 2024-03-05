variable "vpc_id" {
  type        = string
  description = "The VPC ID that you wish to create the security groups in"
}

variable "ingress_http" {
  type = any
}

variable "ingress_https" {
  type = any
}

variable "egress_traffic" {
  type = any
}



