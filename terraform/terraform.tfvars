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
type         = ["forward","forward","forward"]
path_pattern = ["/api/lights", "/api/heating", "/api/status"]


#alb target groups
alb_target_group_port       = [3000]
alb_target_group_protocol   = ["HTTP"]
instance_health_check_paths = ["/api/lights/health", "/api/heating/health", "/api/status/health"]  



##################
instance_count = 3

