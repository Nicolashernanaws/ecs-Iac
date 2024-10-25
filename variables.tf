

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}


variable "ecr_registry" {
  type        = string
  description = "URL del registro ECR"
}

variable "ecr_repository" {
  type        = string
  description = "Nombre del repositorio en ECR"
}



variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "nc-ecs-cluster"
}

variable "task_family" {
  description = "Family name of the ECS task definition"
  type        = string
  default     = "nc-task"
}

variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = "nc-container"
}

variable "container_image" {
  description = "Docker image for the container"
  type        = string
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
  default     = 80
}

variable "task_cpu" {
  description = "CPU units for the task"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Memory (in MiB) for the task"
  type        = number
  default     = 512
}

variable "container_cpu" {
  description = "CPU units for the container"
  type        = number
  default     = 256
}

variable "container_memory" {
  description = "Memory (in MiB) for the container"
  type        = number
  default     = 512
}

variable "task_desired_count" {
  description = "Desired number of tasks running"
  type        = number
  default     = 2
}


variable "domain_name" {
  description = "Domain name for Route53 record"
  type        = string
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "nc-alb"
}


variable "launch_template_name" {
  description = "Name of the launch template"
  type        = string
  default     = "nc-launch-template"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "asg_min_size" {
  description = "Minimum size of Auto Scaling Group"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum size of Auto Scaling Group"
  type        = number
  default     = 3
}

variable "asg_desired_capacity" {
  description = "Desired capacity of Auto Scaling Group"
  type        = number
  default     = 2
}


variable "execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
  default     = "nc-service"
}