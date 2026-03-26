variable "project_name" {
  description = "Project name used for tagging AWS resources."
  type        = string
}

variable "environment" {
  description = "Environment name such as dev or prod."
  type        = string
}

variable "aws_region" {
  description = "AWS region where networking resources will be created."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet."
  type        = string
  default     = "10.0.2.0/24"
}
