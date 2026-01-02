variable "name" {
  type        = string
  description = "Name prefix"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for ECS tasks"
}

variable "alb_sg_id" {
  type        = string
  description = "ALB security group id (allowed to reach ECS tasks)"
}

variable "target_group_arn" {
  type        = string
  description = "Target group ARN for the ECS service"
}

variable "container_port" {
  type    = number
  default = 80
}

variable "desired_count" {
  type    = number
  default = 2
}

