output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = aws_launch_template.nc_lt.id
}

output "launch_template_arn" {
  description = "ARN of the Launch Template"
  value       = aws_launch_template.nc_lt.arn
}

output "autoscaling_group_id" {
  description = "ID of the Auto Scaling Group"
  value       = aws_autoscaling_group.nc_asg.id
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.nc_asg.name
}

output "autoscaling_group_arn" {
  description = "ARN of the Auto Scaling Group"
  value       = aws_autoscaling_group.nc_asg.arn
}