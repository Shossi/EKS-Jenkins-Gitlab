output "lb_arn" {
  description = "The ARN of the load balancer"
  value       = aws_lb.main.arn
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "lb_target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.jenkins_tg.arn
}
output "lb_sg_id" {
  description = "The ID of the load balancer security group"
  value       = aws_security_group.lb_sg.id
}