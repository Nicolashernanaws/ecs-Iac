
resource "aws_launch_template" "nc_lt" {
  name          = var.launch_template_name
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  iam_instance_profile {
    arn = var.iam_inst_profile_arn
  }
  network_interfaces {
    associate_public_ip_address = false
    security_groups            = [var.security_group_id]
    delete_on_termination      = true
  }
  
  user_data = base64encode(<<EOF
#!/bin/bash
echo "ECS_CLUSTER=nc-ecs-cluster" >> /etc/ecs/ecs.config
echo "ECS_ENABLE_TASK_IAM_ROLE=true" >> /etc/ecs/ecs.config
sudo systemctl restart docker
sudo systemctl restart ecs
EOF
  )
  monitoring {
    enabled = var.enable_detailed_monitoring
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }
  tags = merge(
    {
      Name        = var.launch_template_name
      Environment = var.environment
    },
    var.tags
  )
  lifecycle {
    create_before_destroy = true
  }
}


data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_autoscaling_group" "nc_asg" {
  name                = var.autoscaling_group_name
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.private_subnets
  target_group_arns   = [var.target_group_arn]
  health_check_type         = "ELB"
  health_check_grace_period = var.health_check_grace_period

  launch_template {
    id      = aws_launch_template.nc_lt.id
    version = "$Latest"
  }

  dynamic "tag" {
    for_each = merge(
      {
        Name                = var.autoscaling_group_name
        Environment        = var.environment
        AmazonECSManaged  = true
      },
      var.asg_tags
    )
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
      instance_warmup       = 300
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_capacity]
  }

  protect_from_scale_in = var.protect_from_scale_in
}

resource "aws_autoscaling_policy" "scale_up" {
  count                  = var.enable_scaling_policies ? 1 : 0
  name                   = "${var.autoscaling_group_name}-scale-up"
  autoscaling_group_name = aws_autoscaling_group.nc_asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown              = 300
}

resource "aws_autoscaling_policy" "scale_down" {
  count                  = var.enable_scaling_policies ? 1 : 0
  name                   = "${var.autoscaling_group_name}-scale-down"
  autoscaling_group_name = aws_autoscaling_group.nc_asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown              = 300
}