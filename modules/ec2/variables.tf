variable "project_name" {
  description = "Project name used for tagging AWS resources."
  type        = string
}

variable "environment" {
  description = "Environment name such as dev or prod."
  type        = string
}

variable "aws_region" {
  description = "AWS region where the EC2 instance will be created."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the server."
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be launched."
  type        = string
}

variable "security_group_id" {
  description = "Security group ID to attach to the EC2 instance."
  type        = string
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name used for SSH access."
  type        = string
}
