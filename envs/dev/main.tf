module "network" {
  source = "../../modules/network"

  name = "ecs-fargate-alb-dev"

  vpc_cidr = "10.0.0.0/16"
  azs      = ["us-east-1a", "us-east-1b"]

  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
}

module "alb" {
  source = "../../modules/alb"

  name              = "ecs-fargate-alb-dev"
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids

  listener_port = 80
}

module "ecs" {
  source = "../../modules/ecs"

  name               = "ecs-fargate-alb-dev"
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids

  alb_sg_id        = module.alb.alb_sg_id
  target_group_arn = module.alb.target_group_arn

  container_port = 80
  desired_count  = 2
}

