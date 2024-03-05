variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
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
variable "table_name" {
  type = map(string)
}

variable "hash_key_name" {
  type = map(string)
}

variable "hash_key_type" {
  type = map(string)
}


variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}
