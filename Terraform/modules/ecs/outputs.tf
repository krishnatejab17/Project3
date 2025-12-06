output "ecs_cluster_id" {
  value = aws_ecs_cluster.this.id
}

output "ecs_service_name" {
  value = aws_ecs_service.service.name
}

output "ecs_task_definition" {
  value = aws_ecs_task_definition.task.arn
}

output "ecs_security_group" {
  value = aws_security_group.ecs_sg.id
}
