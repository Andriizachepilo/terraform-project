module "vpc" {
  source = "./modules/networking"
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  availability_zones = var.availability_zones
}

module "security_groups" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  ingress_http = var.ingress_http
  ingress_https = var.ingress_https
  egress_traffic = var.egress_traffic
}