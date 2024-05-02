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

variable "vpc_id" {
  type = string
}

variable "ilb_target_group_listener_port" {
  type = number
}

variable "ilb_target_group_listener_protocol" {
  type = string
}

variable "target_private_instance" {
  type = string
}

variable "private_instance_health_check" {
  type = string
}