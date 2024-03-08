variable "security_groups" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "ilb_listener_port" {
  type = number
}

variable "ilb_listener_protocol" {
  type = string
}

variable "target_group_arn" {
  type = string
}