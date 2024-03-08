variable "cidr_block" {
  type = string
}
variable "public_subnets" {
  type        = list(string)
  description = "Specifies the list of public subnets where your public-facing resources, such as load balancers or web servers, will be deployed."
}

variable "private_subnets" {
  type        = list(string)
  description = "Specifies the list of private subnets where your internal resources, such as databases or application servers, will be deployed."
}

variable "availability_zones" {
  type        = list(string)
  description = "Specifies the list of availability zones where your resources will be distributed. Each subnet typically corresponds to an availability zone."
}

variable "ingress_http" {
  type        = any
  description = "Specifies the ingress rules for HTTP traffic. This variable could represent security group rules allowing HTTP traffic from specific sources."
}

variable "ingress_https" {
  type        = any
  description = "Specifies the ingress rules for HTTPS traffic. This variable could represent security group rules allowing HTTPS traffic from specific sources."
}

variable "egress_traffic" {
  type        = any
  description = "Specifies the egress rules for outbound traffic. This variable could represent security group rules allowing outbound traffic to specific destinations."
}

variable "table_name" {
  type        = map(string)
  description = "Specifies a mapping between resource names and their corresponding table names."
}

variable "hash_key_name" {
  type        = map(string)
  description = "Specifies a mapping between resource names and their corresponding hash key names. "
}

variable "hash_key_type" {
  type        = map(string)
  description = "Specifies a mapping between resource names and their corresponding hash key types. "
}

variable "instance_type" {
  type        = string
  description = "Specifies the instance type for EC2 instances, such as t2.micro, m5.large, etc."
}

variable "key_name" {
  type        = string
  description = "Specifies the name of the SSH key pair used for accessing EC2 instances."
}

variable "alb_listener_protocol" {
  type        = string
  description = "Specifies the protocol used by the ALB listener, such as HTTP or HTTPS."
}

variable "alb_target_group_port" {
  type        = list(number)
  description = "Specifies the port number for the ALB target group."
}

variable "alb_target_group_protocol" {
  type        = list(string)
  description = "Specifies the protocol used by the ALB target group, such as HTTP or HTTPS."
}

variable "ilb_listener_port" {
  type        = number
  description = "Specifies the port number for the ILB listener."
}

variable "ilb_listener_protocol" {
  type        = string
  description = "Specifies the protocol used by the ILB listener, such as HTTP or HTTPS."
}

variable "ilb_target_group_listener_port" {
  type        = number
  description = "Specifies the port number for the ILB target group listener."
}

variable "ilb__target_group_listener_protocol" {
  type        = string
  description = "Specifies the protocol used by the ILB target group listener, such as HTTP or HTTPS."
}

variable "instance_health_check_paths" {
  description = "List of health check paths for each instance"
  default     = ["/api/lights/health", "/api/status/health", "/api/heating"]
  type        = list(string)
}

variable "private_instance_health_check" {
  type = string
}


variable "alb_listener_port" {
  type = number
}

variable "type" {
  type = list(string)
}


variable "path_pattern" {
  type = list(string)
}

variable "instance_count" {
  description = "value"
  type        = number
}
