
resource "aws_security_group" "nc_alb_nc" {
  name        = "nc-alb-sg"
  description = "Security group for ALB"
  vpc_id      = data.aws_vpc.internship_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nc-alb-sg"
  }
}

resource "aws_security_group" "nc_ecs_sg" {
  name        = "nc-ecs-sg"
  description = "Security group for ECS instances"
  vpc_id      = data.aws_vpc.internship_vpc.id

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.nc_alb_nc.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nc-ecs-sg"
  }
}