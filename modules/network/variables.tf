variable "name" {
  type        = string
  description = "Name prefix for resources"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "azs" {
  type        = list(string)
  description = "Availability zones (2)"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDRs (2)"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDRs (2)"
}

