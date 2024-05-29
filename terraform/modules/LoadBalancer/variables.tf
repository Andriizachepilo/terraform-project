variable "security_groups" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "alb_listener_protocol" {
  type = string
}

variable "lb_type" {
  type = string
}

variable "type" {
  description = "Type of default rule (listener)"
  type        = string
}

variable "path_pattern" {
  type = list(string)
}


variable "targets_id" {
  type = list(string)
}

variable "alb_target_group_port" {
  type = number
}

variable "alb_target_group_protocol" {
  type = string
}

variable "instance_health_check_paths" {
  type = list(string)
}

variable "alb_tg_name" {
  type = list(string)
}

variable "ilb_security_groups" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "ilb_listener_protocol" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ilb_target_group_listener_port" {
  type = number
}
variable "ilb_listener_port" {
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