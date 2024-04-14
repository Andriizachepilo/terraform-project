variable "name_asg_public" {
  type = list(string)
}

variable "name_asg_private" {
  type = string
}

variable "public_target_group_arn" {
  type = list(string)
}

variable "private_target_group_arn" {
  type = string
}

