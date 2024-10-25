
data "aws_vpc" "internship_vpc" {
  id = "vpc-01fc1ec68a8b03eb9"
}

data "aws_subnet" "public_subnet_1" {
  id = "subnet-0d4b3436fdda9803f"
}

data "aws_subnet" "public_subnet_2" {
  id = "subnet-09d1848907ea68bca"
}

data "aws_subnet" "private_subnet_1" {
  id = "subnet-0d5a03c63e1d24a17"
}

data "aws_subnet" "private_subnet_2" {
  id = "subnet-00ec5ce7c1e376323"
}

data "aws_nat_gateway" "NG2" {
  subnet_id = data.aws_subnet.public_subnet_2.id
}

data "aws_nat_gateway" "NG1" {
  subnet_id = data.aws_subnet.public_subnet_1.id
}

data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.internship_vpc.id]
  }
}

data "aws_route53_zone" "hosted_zone" {
  name = "teracloud.lat"
}

data "aws_acm_certificate" "nc-certificate" {
  domain      = "sdepetri.site"
  statuses    = ["ISSUED"]
  most_recent = true
}


module "network" {
  source = "./modules/network"
}


module "alb" {
  source = "./modules/alb"

  alb_name           = var.alb_name
  certificate_arn    = data.aws_acm_certificate.nc-certificate.arn
  security_group_id  = aws_security_group.nc_alb_nc.id
  public_subnets     = [data.aws_subnet.public_subnet_1.id, data.aws_subnet.public_subnet_2.id]
  vpc_id             = data.aws_vpc.internship_vpc.id
  target_group_name  = "nc-target-group"
}


module "autoscaling" {
  source = "./modules/autoscaling"

  launch_template_name    = var.launch_template_name
  instance_type          = var.instance_type
  autoscaling_group_name = "nc-asg"
  security_group_id      = aws_security_group.nc_ecs_sg.id
  private_subnets        = [data.aws_subnet.private_subnet_1.id, data.aws_subnet.private_subnet_2.id]
  target_group_arn       = module.alb.target_group_arn
  min_size              = var.asg_min_size
  max_size              = var.asg_max_size
  desired_capacity      = var.asg_desired_capacity
  iam_inst_profile_arn  = "arn:aws:iam::253490770873:instance-profile/ecsInstanceRole"
}


module "nc_ecs" {
  source = "./modules/nc-ecs"
  
  cluster_name       = var.cluster_name
  task_family       = var.task_family
  container_name    = var.container_name
  container_image   = var.container_image
  task_cpu         = var.task_cpu
  task_memory      = var.task_memory
  container_cpu    = var.container_cpu
  container_memory = var.container_memory
  container_port   = var.container_port
  service_name     = var.service_name
  task_desired_count = var.task_desired_count
  target_group_arn = module.alb.target_group_arn
  execution_role_arn = var.execution_role_arn  
}