variable "max_size" {
  type = list(number)
}

variable "min_size" {
  type = list(number)
}

variable "health_check_type" {
  type = list(string)
}


variable "desired_capacity" {
  type = list(number)
}

variable "subnets_for_autoscaling_group" {
  type = list(string)
}


variable "max_size_private" {
  type = number
}

variable "min_size_private" {
  type = number
}

variable "desired_capacity_private" {
  type = number
}

variable "subnets_for_autoscaling_group_private" {
  type = list(string)
}

variable "health_check_type_private" {
  type = string
}
variable "name_asg_public" {
  type = list(string)
}

variable "name_asg_private" {
  type = string
}

variable "private_launch_id" {
  type = string
}

variable "version_of_launch_template" {
  type = list(string)
}

variable "version_of_launch_template_private" {
  type = string
}

variable "public_launch_id" {
  type = list(string)
}



variable "public_target_group_arn" {
  type = list(string)
}

variable "private_target_group_arn" {
  type = string
}

