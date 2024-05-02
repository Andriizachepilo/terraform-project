variable "image_id" {
  type = list(string)
}
variable "template_name" {
  type = list(string)
}
variable "instance_type" {
  type = string
}
variable "key_name" {
  type = string
}
variable "vpc_security_group_ids" {
  type = list(string)
}

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "template_name_private" {
  description = "can not use the same variable since its not a list "
  type        = string
}

variable "private_image_id" {
  description = "can not use the same variable since its not a list "
  type        = string
}

variable "private_security_group" {
  type        = list(string)
  description = "Secutiry groups for private launch template"
}
