variable "public_subnets" {
  description = "List of public subnet IDs."
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet IDs."
  type        = list(string)
}


variable "security_group_ids" {
  description = "List of security group ID."
  type        = list(string)
}

variable "instance_type" {
  type = string
}

variable "security_group_ids_private_ec2" {
  type = list(string)
}
variable "key_name" {
  type = string
}

variable "bastion_SG" {
  type = list(string)
}
