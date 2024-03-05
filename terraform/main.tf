module "vpc" {
  source             = "./modules/networking"
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
  bastion_SG                     = [module.security_groups.bastion_SG]
  key_name                       = var.key_name


}
