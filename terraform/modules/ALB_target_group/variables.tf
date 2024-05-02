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
