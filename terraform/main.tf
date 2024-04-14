module "vpc" {
  source             = "./modules/Networking"
  cidr_block         = var.cidr_block
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}

module "security_groups" {
  source = "./modules/Security_Group"
  vpc_id = module.vpc.vpc_id
}

module "dynamoDB" {
  source        = "./modules/Databases"
  table_name    = var.table_name
  hash_key_name = var.hash_key_name
  hash_key_type = var.hash_key_type
}

module "ec2" {
  source                         = "./modules/EC2"
  instance_type                  = var.instance_type
  public_subnets                 = module.vpc.public_subnets
  private_subnets                = module.vpc.private_subnets
  security_group_ids             = [module.security_groups.public_sg_id]
  security_group_ids_private_ec2 = [module.security_groups.private_sg_id]
  key_name                       = var.key_name
  bastion_SG                     = [module.security_groups.bastion_sg_id]
}

module "application_load_balancer_target_group" {
  source                      = "./modules/ALB_target_group"
  alb_tg_name                 = var.alb_tg_name
  targets_id                  = module.ec2.public_instance_ids
  vpc_id                      = module.vpc.vpc_id
  alb_target_group_port       = var.alb_target_group_port
  alb_target_group_protocol   = var.alb_target_group_protocol
  instance_health_check_paths = var.instance_health_check_paths


}

module "application_load_balancer" {
  source                  = "./modules/Application_LB"
  public_target_group_arn = module.application_load_balancer_target_group.target_group_arn
  public_subnets          = module.vpc.public_subnets
  security_groups         = [module.security_groups.public_sg_id]
  path_pattern            = var.path_pattern
  type                    = var.type
  alb_listener_port       = var.alb_listener_port
  alb_listener_protocol   = var.alb_listener_protocol

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
  source                = "./modules/Internal_LB"
  target_group_arn      = module.internal_load_balancer_target_group.arn
  ilb_listener_port     = var.ilb_listener_port
  ilb_listener_protocol = var.ilb_listener_protocol
  security_groups       = [module.security_groups.private_sg_id]
  private_subnets       = module.vpc.private_subnets
}

module "run_script_instances_id" {
  source     = "./modules/script_custom_ami_ids"
  depends_on = [module.ec2]
}


module "launch_template" {
  source                 = "./modules/launch_template"
  image_id               = var.image_id
  key_name               = var.key_name
  instance_type          = var.instance_type
  template_name          = var.template_name
  vpc_security_group_ids = [module.security_groups.public_sg_id]
  private_image_id       = var.private_image_id
  template_name_private  = var.template_name_private
  private_security_group = [module.security_groups.private_sg_id]
  public_subnet_id       = module.vpc.public_subnets[0]
  private_subnet_id      = module.vpc.private_subnets[0]
}


module "asg_private_and_public_launch" {
  source                                = "./modules/Autoscaling"
  name_asg_private                      = var.name_asg_private
  max_size_private                      = var.max_size_private
  min_size_private                      = var.min_size_private
  desired_capacity_private              = var.desired_capacity_private
  health_check_type_private             = var.health_check_type_private
  version_of_launch_template_private    = var.version_of_launch_template_private
  private_launch_id                     = module.launch_template.launch_template_for_private_service
  subnets_for_autoscaling_group_private = module.vpc.private_subnets

  name_asg_public               = var.name_asg_public
  max_size                      = var.max_size
  min_size                      = var.min_size
  desired_capacity              = var.desired_capacity
  health_check_type             = var.health_check_type
  version_of_launch_template    = var.version_of_launch_template
  public_launch_id              = module.launch_template.launch_template_for_public_services
  subnets_for_autoscaling_group = module.vpc.public_subnets
 
}

module "asg_attachment_private_and_public" {
  source                   = "./modules/Autoscaling_attachment"
  name_asg_public          = var.name_asg_public
  public_target_group_arn  = module.application_load_balancer_target_group.target_group_arn
  name_asg_private         = var.name_asg_private
  private_target_group_arn = module.internal_load_balancer_target_group.arn
  depends_on               = [module.asg_private_and_public_launch]
}
