variable "security_groups" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "alb_listener_port" {
  type = number
}

variable "alb_listener_protocol" {
  type = string
}

variable "lb_type" {
  type = string
  
}

variable "public_target_group_arn" {
  type = list(string)
}


variable "type" {
  type = string
}
variable "path_pattern" {
  type = list(string)
}

variable "vpc_id" {
  type = string
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
