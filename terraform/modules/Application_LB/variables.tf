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


variable "public_target_group_arn" {
  type = list(string)
}


variable "type" {
  type = list(string)
}
variable "path_pattern" {
  type = list(string)
}

