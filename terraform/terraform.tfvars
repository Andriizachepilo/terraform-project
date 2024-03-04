public_subnets = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
availability_zones = ["eu-west-2a","eu-west-2b","eu-west-2c"]
ingress_http = {
    "HTTP" = {from_port = 80, to_port = 80,protocol = "tcp", cidr_blocks = ["0.0.0.0/0"]}
}
ingress_https = {
    "HTTPS" = {from_port = 80, to_port = 80,protocol = "tcp", cidr_blocks = ["0.0.0.0/0"]}
}
egress_traffic = {
    "outbound" = {from_port = 0,to_port = 0,protocol = "tcp",cidr_blocks = ["0.0.0.0/0"]}
}

