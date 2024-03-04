variable "public_subnets" {
  type        = list(string)
  description = "A list of the CIDR ranges required for the public subnets"
}

variable "private_subnets" {
  type        = list(string)
  description = "A list of the CIDR ranges required for the private subnets"
}

variable "availability_zones" {
    type = list(string)
    description = "A list of the Availability Zones you wish to provision infrastructure in"
    
}

