variable "region" {
  type    = string
  default = "us-east-1"
}

variable "env" {
  type    = string
  default = "prod"
}
variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "name" {
  type    = string
  default = "ecs-fargate-alb-prod"
}

variable "vpc_cidr" {
  type    = string
  default = "10.1.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.1.101.0/24", "10.1.102.0/24"]
}

