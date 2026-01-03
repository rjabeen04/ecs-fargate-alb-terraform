module "network" {
  source = "../../modules/network"

  name = var.name

  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "alb" {
  source = "../../modules/alb"

  name               = var.name
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  enable_waf         = true
  enable_access_logs = true
  access_logs_bucket = aws_s3_bucket.alb_logs.bucket
  access_logs_prefix = "ecs-fargate-alb-prod"

  depends_on = [aws_s3_bucket_policy.alb_logs]


}

module "ecs" {
  source = "../../modules/ecs"

  name               = var.name
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids

  alb_sg_id        = module.alb.alb_sg_id
  target_group_arn = module.alb.target_group_arn

  container_port = 80
  desired_count  = 2
}








