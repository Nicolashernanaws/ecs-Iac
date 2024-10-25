terraform {
  required_version = ">= 1.9.5"
  backend "s3" {
    bucket         = "nc-pipeline-php"
    key            = "terraform-ecs/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "sd_terraform_lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}