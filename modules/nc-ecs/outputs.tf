output "cluster_id" {
  description = "ID of the ECS cluster"
  value       = aws_ecs_cluster.nc_cluster.id
}

output "cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.nc_cluster.name
}

output "cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = aws_ecs_cluster.nc_cluster.arn
}

output "service_id" {
  description = "ID of the ECS service"
  value       = aws_ecs_service.nc_service.id
}

output "service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.nc_service.name
}

output "task_definition_arn" {
  description = "ARN of the task definition"
  value       = aws_ecs_task_definition.nc_task.arn
}

output "task_definition_family" {
  description = "Family of the task definition"
  value       = aws_ecs_task_definition.nc_task.family
}