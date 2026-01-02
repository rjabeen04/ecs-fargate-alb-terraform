output "alb_arn" {
  value = aws_lb.this.arn
}

output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}

output "waf_web_acl_arn" {
  value = try(aws_wafv2_web_acl.this[0].arn, null)
}

