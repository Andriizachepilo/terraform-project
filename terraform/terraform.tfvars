#Networking

cidr_block         = "10.0.0.0/16"
public_subnets     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
private_subnets    = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]

#Secutiry groups


ingress_http = {
  "HTTP"                    = { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  "allow_http_on_port_3000" = { from_port = 3000, to_port = 3000, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
}

ingress_https = {
  "HTTPS" = { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
}
egress_traffic = {
  "outbound" = { from_port = 0, to_port = 65535, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
}

#DynamoDB 

table_name = {
  "dynamo_DB_1" = "lighting_table"
  "dynamo_DB_2" = "heating_table"
}
hash_key_type = {
  "dynamo_DB_1" = "N"
  "dynamo_DB_2" = "N"
}
hash_key_name = {
  "dynamo_DB_1" = "lighting_key"
  "dynamo_DB_2" = "heating_key"
}


#EC2 Instances

instance_type = "t2.micro"
key_name      = "my-key-pair"


#Internal load balancer 

ilb_listener_port                   = 3000
ilb_listener_protocol               = "HTTP"
ilb_target_group_listener_port      = 3000
ilb__target_group_listener_protocol = "HTTP"
private_instance_health_check       = "/api/auth"


#Aplication load balancer 
alb_listener_port     = 80
alb_listener_protocol = "HTTP"

#alb listener rules
type         = ["forward", "forward", "forward"]
path_pattern = ["/api/lights", "/api/heating", "/api/status"]


#alb target groups
alb_tg_name                 = ["tg-lights", "tg-heating", "tg-status"]
alb_target_group_port       = [3000, 3000, 3000]
alb_target_group_protocol   = ["HTTP", "HTTP", "HTTP"]
instance_health_check_paths = ["/api/lights/health", "/api/heating/health", "/api/status/health"]


#launch template with public services

image_id      = ["ami-06b1d61aeb0123dea", "ami-090f22ececb80c818", "ami-09079ecef4e5362e6"]
template_name = ["service_lighting", "service_heating", "service_status"]



#launch template with the private service
private_image_id      = "ami-004926468c0bf8928"
template_name_private = "service_auth"



#autoscailing group for public launch templates
name_asg_public            = ["lighting_asg", "heating_asg", "status_asg"]
version_of_launch_template = ["$Latest", "$Latest", "$Latest"]
desired_capacity           = [0, 0, 0]
min_size                   = [0, 0, 0]
max_size                   = [0, 0, 0]
health_check_type          = ["ELB", "ELB", "ELB"]


#autoscailing group for private launch template
name_asg_private                   = "auth_asg"
max_size_private                   = 0
min_size_private                   = 0
desired_capacity_private           = 0
health_check_type_private          = "ELB"
version_of_launch_template_private = "$Latest"





