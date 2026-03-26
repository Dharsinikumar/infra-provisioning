variable "project_name" {
  description = "Project name used for naming and tagging resources."
  type        = string
}

variable "environment" {
  description = "Environment name such as dev or prod."
  type        = string
}

variable "aws_region" {
  description = "AWS region where resources will be deployed."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the web server."
  type        = string
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name used for SSH access."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet."
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet."
  type        = string
}
