
resource "aws_ecs_cluster" "nc_cluster" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }

  tags = merge(
    {
      Name        = var.cluster_name
      Environment = var.environment
    },
    var.tags
  )
}

resource "aws_ecs_task_definition" "nc_task" {
  family                   = var.task_family
  execution_role_arn       = var.execution_role_arn
  task_role_arn           = var.task_role_arn
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory

  container_definitions = jsonencode([
    {
      name         = var.container_name
      image        = var.container_image
      cpu          = var.container_cpu
      memory       = var.container_memory
      essential    = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/${var.cluster_name}/${var.container_name}"
          "awslogs-region"        = data.aws_region.current.name
          "awslogs-stream-prefix" = "ecs"
        }
      }
      environment = var.container_environment
      secrets     = var.container_secrets
    }
  ])

  tags = merge(
    {
      Name        = var.task_family
      Environment = var.environment
    },
    var.tags
  )
}

resource "aws_ecs_service" "nc_service" {
  name                              = var.service_name
  cluster                          = aws_ecs_cluster.nc_cluster.id
  task_definition                  = aws_ecs_task_definition.nc_task.arn
  desired_count                    = var.task_desired_count
  launch_type                      = "EC2"
  deployment_maximum_percent       = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  health_check_grace_period_seconds = var.health_check_grace_period

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  deployment_circuit_breaker {
    enable   = var.enable_circuit_breaker
    rollback = var.enable_circuit_breaker_rollback
  }

  tags = merge(
    {
      Name        = var.service_name
      Environment = var.environment
    },
    var.tags
  )
}


data "aws_region" "current" {}