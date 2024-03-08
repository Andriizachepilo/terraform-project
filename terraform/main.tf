module "vpc" {
  source             = "./modules/networking"
  cidr_block = var.cidr_block
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}

module "security_groups" {
  source         = "./modules/security_group"
  vpc_id         = module.vpc.vpc_id
  ingress_http   = var.ingress_http
  ingress_https  = var.ingress_https
  egress_traffic = var.egress_traffic
}

module "dynamoDB_table" {
  source        = "./modules/dynamo_db_tables"
  table_name    = var.table_name
  hash_key_name = var.hash_key_name
  hash_key_type = var.hash_key_type
}

module "ec2" {
  source                         = "./modules/ec2_instances"
  instance_type                  = var.instance_type
  public_subnets                 = module.vpc.public_subnets
  private_subnets                = module.vpc.private_subnets
  security_group_ids             = module.security_groups.security_group_ids
  security_group_ids_private_ec2 = [module.security_groups.security_group_private_instances]
  key_name                       = var.key_name
}

module "public_load_balancer_target_group" {
  source                      = "./modules/ALB_target_group"
  targets_id                  = module.ec2.public_instance_ids
  vpc_id                      = module.vpc.vpc_id
  alb_target_group_port       = var.ilb_listener_port
  alb_target_group_protocol   = var.alb_listener_protocol
  instance_health_check_paths = var.instance_health_check_paths
  instance_count = var.instance_count

}

module "public_load_balancer" {
  source                  = "./modules/public_ALB"
  public_target_group_arn = module.public_load_balancer_target_group.target_group_arn
  public_subnets          = module.vpc.public_subnets
  security_groups         = module.security_groups.security_group_ids
  path_pattern            = var.path_pattern
  type                    = var.type
  alb_listener_port       = var.alb_listener_port
  alb_listener_protocol   = var.alb_listener_protocol
  instance_count = var.instance_count
}

module "internal_load_balancer_target_group" {
  source                             = "./modules/ILB_target_group"
  vpc_id                             = module.vpc.vpc_id
  ilb_target_group_listener_port     = var.ilb_listener_port
  ilb_target_group_listener_protocol = var.ilb_listener_protocol
  target_private_instance            = module.ec2.private_instance_id
  private_instance_health_check      = var.private_instance_health_check
}

module "internal_load_balancer" {
  source                = "./modules/internal_LB"
  target_group_arn      = module.internal_load_balancer_target_group.arn
  ilb_listener_port     = var.ilb_listener_port
  ilb_listener_protocol = var.ilb_listener_protocol
  security_groups       = [module.security_groups.security_group_private_instances]
  private_subnets       = module.vpc.private_subnets
}

