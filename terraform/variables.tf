variable "public_subnets" {
  type        = list(string)
}

variable "private_subnets" {
  type        = list(string)
}

variable "availability_zones" {
  type = list(string)
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
