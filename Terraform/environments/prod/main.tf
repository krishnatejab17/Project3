terraform {
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source       = "../../modules/vpc"

  environment  = var.environment
  app_name     = var.app_name

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}


module "alb" {
  source       = "../../modules/alb"
  vpc_id       = module.vpc.vpc_id
  app_name     = var.app_name
  environment  = var.environment
  public_subnets = module.vpc.public_subnets
}

module "ecr" {
  source       = "../../modules/ecr"
  app_name     = var.app_name
  environment  = var.environment
}

module "iam" {
  source       = "../../modules/iam"
  app_name     = var.app_name
  environment  = var.environment

  github_repo = "krishnatejab17/Project3"
  
}

module "ecs" {
  source = "../../modules/ecs"

  app_name     = var.app_name
  environment  = var.environment
  container_port = var.container_port
  region        = var.region

  vpc_id            = module.vpc.vpc_id
  private_subnets   = module.vpc.private_subnets

  
  target_group_arn  = module.alb.blue_target_group_arn

  alb_security_group = module.alb.alb_security_group

  execution_role_arn = module.iam.execution_role_arn

  image_url = "${module.ecr.repository_url}:${var.image_tag}"

}


module "codedeploy" {
  source = "../../modules/codedeploy"

  app_name    = var.app_name
  environment = var.environment

  cluster_name = module.ecs.ecs_cluster_id
  service_name = module.ecs.ecs_service_name

  blue_target_group_arn  = module.alb.blue_target_group_arn
  green_target_group_arn = module.alb.green_target_group_arn
  listener_arn           = module.alb.listener_arn

  codedeploy_role_arn = module.iam.codedeploy_role_arn
}



