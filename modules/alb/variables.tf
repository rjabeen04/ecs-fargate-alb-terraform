variable "name" {
  type        = string
  description = "Name prefix"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnet IDs for ALB"
}

variable "listener_port" {
  type        = number
  description = "ALB listener port"
  default     = 80
}

variable "enable_waf" {
  type        = bool
  description = "Attach AWS WAFv2 to the ALB"
  default     = true
}

