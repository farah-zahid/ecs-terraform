module "vpc" {
  source              = "./modules/vpc"
  name                = "ecs"
  cidr                = "10.0.0.0/16"
  azs                 = ["us-east-1a", "us-east-1b"]
  public_subnets      = ["10.0.0.0/19", "10.0.32.0/19"]
  private_subnet      = ["10.0.64.0/19", "10.0.96.0/19"]

  enable_nat_gateway  = true

  tags = {
    Terraform = "true"
    Environment = var.environment
  }
}

module "ecs_cluster" {
  source              = "./modules/ecs_cluster"
  name                = "nginx-ecs-cluster"
  container_insights  = true

  tags = {
    Terraform = "true"
    Environment = var.environment
  }
}

module "nginx_ecs_sg" {
  source                = "./modules/security_group"
  create                = true
  name                  = "nginx-${var.environment}-ecs-security-group"
  vpc_id                = module.vpc.vpc_id
  source_cidr_block     = true
  source_cidr_rules     = local.payload_nginx_ecs_cidr_rules
  source_security_group = false
  source_self           = false

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

module "nginx_alb_sg" {
  source                = "./modules/security_group"
  create                = true
  name                  = "nginx-${var.environment}-alb-security-group"
  vpc_id                = module.vpc.vpc_id
  source_cidr_block     = true
  source_cidr_rules     = local.payload_nginx_alb_cidr_rules
  source_security_group = false
  source_self           = false

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

module "nginx_lb" {
  source          = "./modules/aws_alb"
  create_lb       = true
  name            = "nginx-${var.environment}"
  security_groups = [module.nginx_alb_sg.security_group_id]
  subnets         = module.vpc.public_subnets

  // Targate group
  create_target_group = true
  protocol            = "HTTP"
  port                = "80"
  vpc_id              = module.vpc.vpc_id

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

data "template_file" "nginx" {
  template = file("task-definitions/nginx.json")

  vars = {
    image_url         = "nginx:latest"
    container_name    = "nginx"
  }
}

resource "aws_s3_bucket" "nginx" {
  bucket = "nginx-${var.environment}-egdfgdfhhs"

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

module "nginx_service" {
  source                = "./modules/ecs_service"
  name                  = "nginx-${var.environment}"
  cluster_id            = module.ecs_cluster.cluster_id
  desired_count         = 1
  container_definitions = data.template_file.nginx.rendered
  container_name        = "nginx"

  // Network Configuration
  subnet_ids          = module.vpc.private_subnets
  security_group_ids  = [module.nginx_ecs_sg.security_group_id]

  // Loadbalancer configuration
  target_group_arn  = module.nginx_lb.target_group_arn

  s3_arn            = aws_s3_bucket.nginx.arn

  tags = {
    Terraform = "true"
    Environment = var.environment
  }
}