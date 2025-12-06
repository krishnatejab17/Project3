output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "blue_target_group_arn" {
  value = aws_lb_target_group.blue.arn
}

output "green_target_group_arn" {
  value = aws_lb_target_group.green.arn
}

output "alb_security_group" {
  value = aws_security_group.alb_sg.id
}

output "listener_arn" {
  value = aws_lb_listener.listener.arn
}
