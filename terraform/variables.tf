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
  description = "Specifies the health check type for instances in a private subnet."
  type        = string
}


variable "alb_listener_port" {
  description = "Specifies the port number for the Application Load Balancer (ALB) listener."
  type        = number
}

variable "type" {
  description = "Type of default rule (listener)"
  type        = list(string)
}


variable "path_pattern" {
  description = "List of path patterns for routing requests to different target groups."
  type        = list(string)
}


variable "image_id" {
  description = "List of AMI IDs for instances."
  type        = list(string)
}

variable "template_name" {
  description = "List of launch template names."
  type        = list(string)
}

variable "template_name_private" {
  description = "Specifies the name of the launch template for instances in a private subnet."
  type        = string
}

variable "private_image_id" {
  description = "Specifies the AMI ID for instances in a private subnet."
  type        = string
}

variable "version_of_launch_template" {
  description = "Specifies the version of the launch template."
  type        = list(string)
}

variable "health_check_type" {
  description = "Specifies the health check type for instances in a public subnet."
  type        = list(string)
}

variable "max_size" {
  description = "Specifies the maximum number of instances in the autoscaling group."
  type        = list(number)
}

variable "min_size" {
  description = "Specifies the minimum number of instances in the autoscaling group."
  type        = list(number)
}

variable "desired_capacity" {
  description = "Specifies the desired number of instances in the autoscaling group."
  type        = list(number)
}

variable "alb_tg_name" {
  description = "Specifies the name of the ALB target groups names"
  type = list(string)
}

variable "max_size_private" {
  description = "Specifies the maximum number of instances in the autoscaling group in a private subnet."
  type        = number
}

variable "min_size_private" {
  description = "Specifies the minimum number of instances in the autoscaling group in a private subnet."
  type        = number
}

variable "desired_capacity_private" {
  description = "Specifies the desired number of instances in the autoscaling group in a private subnet."
  type        = number
}


variable "health_check_type_private" {
  description = "Specifies the health check type for instances in a private subnet."
  type        = string
}

variable "name_asg_public" {
  description = "Specifies the name of the autoscaling group in a public subnet."
  type        = list(string)
}

variable "name_asg_private" {
  description = "Specifies the name of the autoscaling group in a private subnet."
  type        = string
}

variable "version_of_launch_template_private" {
  description = "Specifies the version of the launch template"
  type = string
}



