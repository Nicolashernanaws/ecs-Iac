variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  validation {
    condition     = length(var.alb_name) <= 32 && can(regex("^[a-zA-Z0-9-]+$", var.alb_name))
    error_message = "ALB name must be 32 characters or less and can only contain alphanumeric characters and hyphens."
  }
}

variable "security_group_id" {
  description = "Security Group ID for the ALB"
  type        = string
  validation {
    condition     = can(regex("^sg-", var.security_group_id))
    error_message = "Security group ID must begin with 'sg-'."
  }
}

variable "public_subnets" {
  description = "List of public subnets for the ALB"
  type        = list(string)
  validation {
    condition     = length(var.public_subnets) >= 2
    error_message = "At least two public subnets are required for high availability."
  }
}

variable "target_group_name" {
  description = "Name of the Target Group"
  type        = string
  validation {
    condition     = length(var.target_group_name) <= 32 && can(regex("^[a-zA-Z0-9-]+$", var.target_group_name))
    error_message = "Target group name must be 32 characters or less and can only contain alphanumeric characters and hyphens."
  }
}

variable "vpc_id" {
  description = "VPC ID where the ALB will be deployed"
  type        = string
  validation {
    condition     = can(regex("^vpc-", var.vpc_id))
    error_message = "VPC ID must begin with 'vpc-'."
  }
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate for the HTTPS listener"
  type        = string
  validation {
    condition     = can(regex("^arn:aws:acm:", var.certificate_arn))
    error_message = "Certificate ARN must be a valid ACM certificate ARN."
  }
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "tags" {
  description = "A map of tags to assign to ALB resources"
  type        = map(string)
  default     = {}
}

variable "health_check_path" {
  description = "Health check path for the default target group"
  type        = string
  default     = "/"
}

variable "health_check_port" {
  description = "Port for health checks on the target group"
  type        = number
  default     = 80
  validation {
    condition     = var.health_check_port > 0 && var.health_check_port <= 65535
    error_message = "Health check port must be between 1 and 65535."
  }
}

variable "deregistration_delay" {
  description = "Amount time in seconds for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused"
  type        = number
  default     = 30
  validation {
    condition     = var.deregistration_delay >= 0 && var.deregistration_delay <= 3600
    error_message = "Deregistration delay must be between 0 and 3600 seconds."
  }
}

variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API"
  type        = bool
  default     = true
}

variable "drop_invalid_header_fields" {
  description = "Indicates whether invalid header fields are dropped in application load balancers"
  type        = bool
  default     = true
}

variable "target_type" {
  description = "Type of target that you must specify when registering targets with this target group"
  type        = string
  default     = "ip"
  validation {
    condition     = contains(["instance", "ip", "lambda"], var.target_type)
    error_message = "Target type must be one of: instance, ip, lambda."
  }
}

variable "ssl_policy" {
  description = "Name of the SSL Policy for the HTTPS listener"
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
  validation {
    condition     = can(regex("^ELBSecurityPolicy-", var.ssl_policy))
    error_message = "SSL policy must begin with 'ELBSecurityPolicy-'."
  }
}

variable "http_port" {
  description = "Port for HTTP listener"
  type        = number
  default     = 80
  validation {
    condition     = var.http_port > 0 && var.http_port <= 65535
    error_message = "HTTP port must be between 1 and 65535."
  }
}

variable "https_port" {
  description = "Port for HTTPS listener"
  type        = number
  default     = 443
  validation {
    condition     = var.https_port > 0 && var.https_port <= 65535
    error_message = "HTTPS port must be between 1 and 65535."
  }
}