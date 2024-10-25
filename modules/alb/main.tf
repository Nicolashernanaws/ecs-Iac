resource "aws_lb" "nc_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnets

  
  enable_deletion_protection = true
  drop_invalid_header_fields = true
  
  
  tags = merge(
    {
      Name = var.alb_name
      Environment = var.environment
    },
    var.tags
  )
}

resource "aws_lb_target_group" "nc_tg" {
  name     = var.target_group_name  #
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  
  
  health_check {
    enabled             = true
    interval            = 30
    path                = var.health_check_path
    port                = var.health_check_port
    timeout             = 25
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  
  target_type = "instance"  
  
  
  deregistration_delay = 30

  tags = merge(
    {
      Name = var.target_group_name
      Environment = var.environment
    },
    var.tags
  )
}

resource "aws_lb_listener" "http" {  
  load_balancer_arn = aws_lb.nc_alb.arn
  port              = 80
  protocol          = "HTTP"
  
  
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.nc_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nc_tg.arn
  }

  tags = merge(
    {
      Name = "${var.alb_name}-https-listener"
      Environment = var.environment
    },
    var.tags
  )
}