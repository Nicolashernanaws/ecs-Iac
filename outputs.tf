output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.nc_ecs.cluster_name  
}


output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.network.private_subnet_ids
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = module.nc_ecs.service_name
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = module.autoscaling.autoscaling_group_name
}

output "task_definition_arn" {
  description = "ARN of the task definition"
  value       = module.nc_ecs.task_definition_arn
}

output "alb_endpoint" {
  description = "DNS name for the application"
  value       = "https://${var.domain_name}"
}