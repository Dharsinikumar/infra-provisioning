terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket         = "dharsini-terraform-state-864981745245"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  # Configures Terraform to use the AWS provider in the selected region.
  region = var.aws_region
}

module "vpc" {
  # Creates the reusable VPC, subnets, internet gateway, route table, and security group.
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region
  vpc_cidr     = var.vpc_cidr

  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "ec2" {
  # Launches the EC2 web server inside the public subnet created by the VPC module.
  source = "../../modules/ec2"

  project_name      = var.project_name
  environment       = var.environment
  aws_region        = var.aws_region
  instance_type     = var.instance_type
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.vpc.security_group_id
  key_name          = var.key_name
}
