output "vpc_id" {
  description = "VPC ID"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.network.private_subnet_ids
}

output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "target_group_arn" {
  description = "Target group ARN for ECS service registration"
  value       = module.alb.target_group_arn
}

output "alb_sg_id" {
  description = "Security group ID attached to the ALB"
  value       = module.alb.alb_sg_id
}

