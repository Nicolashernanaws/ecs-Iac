variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  validation {
    condition     = length(var.cluster_name) <= 255
    error_message = "Cluster name must be 255 characters or less."
  }
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "enable_container_insights" {
  description = "Enable CloudWatch Container Insights for the cluster"
  type        = bool
  default     = true
}

variable "task_family" {
  description = "Family of the ECS task definition"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN of the task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the task role"
  type        = string
  default     = ""
}

variable "task_cpu" {
  description = "CPU units for the ECS task (1 vCPU = 1024 CPU units)"
  type        = number
  validation {
    condition     = var.task_cpu > 0
    error_message = "Task CPU must be greater than 0."
  }
}

variable "task_memory" {
  description = "Memory for the ECS task in MiB"
  type        = number
  validation {
    condition     = var.task_memory > 0
    error_message = "Task memory must be greater than 0."
  }
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "container_image" {
  description = "URL of the container image"
  type        = string
}

variable "container_cpu" {
  description = "CPU units for the container"
  type        = number
}

variable "container_memory" {
  description = "Memory for the container in MiB"
  type        = number
}

variable "container_port" {
  description = "Port for the container"
  type        = number
  validation {
    condition     = var.container_port > 0 && var.container_port <= 65535
    error_message = "Container port must be between 1 and 65535."
  }
}

variable "container_environment" {
  description = "Environment variables for the container"
  type        = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "container_secrets" {
  description = "Secrets for the container"
  type        = list(object({
    name      = string
    valueFrom = string
  }))
  default = []
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "task_desired_count" {
  description = "Desired number of tasks"
  type        = number
  default     = 1
}

variable "deployment_maximum_percent" {
  description = "Maximum percentage of tasks that can be running during a deployment"
  type        = number
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  description = "Minimum percentage of tasks that must remain healthy during a deployment"
  type        = number
  default     = 100
}

variable "health_check_grace_period" {
  description = "Health check grace period in seconds"
  type        = number
  default     = 60
}

variable "target_group_arn" {
  description = "ARN of the target group for the ECS service"
  type        = string
}

variable "enable_circuit_breaker" {
  description = "Enable deployment circuit breaker"
  type        = bool
  default     = true
}

variable "enable_circuit_breaker_rollback" {
  description = "Enable deployment circuit breaker rollback"
  type        = bool
  default     = true
}