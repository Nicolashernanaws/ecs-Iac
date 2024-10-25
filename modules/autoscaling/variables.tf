variable "launch_template_name" {
  description = "Name of the launch template"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the instances"
  type        = string
}

variable "iam_inst_profile_arn" {
  description = "ARN of the IAM instance profile"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "enable_detailed_monitoring" {
  description = "Enable detailed monitoring for instances"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Map of tags for Launch Template"
  type        = map(string)
  default     = {}
}

variable "asg_tags" {
  description = "Map of tags for Auto Scaling Group"
  type        = map(string)
  default     = {}
}

variable "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of instances in the ASG"
  type        = number
  validation {
    condition     = var.desired_capacity > 0
    error_message = "Desired capacity must be greater than 0."
  }
}

variable "max_size" {
  description = "Maximum number of instances in the ASG"
  type        = number
  validation {
    condition     = var.max_size > 0
    error_message = "Maximum size must be greater than 0."
  }
}

variable "min_size" {
  description = "Minimum number of instances in the ASG"
  type        = number
  validation {
    condition     = var.min_size >= 0
    error_message = "Minimum size must be 0 or greater."
  }
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the target group"
  type        = string
}

variable "health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  type        = number
  default     = 300
}

variable "protect_from_scale_in" {
  description = "Prevents EC2 instances from being terminated during scale-in"
  type        = bool
  default     = false
}

variable "enable_scaling_policies" {
  description = "Enable basic scaling policies"
  type        = bool
  default     = false
}