output "vpc_id" {
  description = "ID of the VPC created for the dev environment."
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet in the dev environment."
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "ID of the private subnet in the dev environment."
  value       = module.vpc.private_subnet_id
}

output "security_group_id" {
  description = "ID of the security group used by the EC2 instance."
  value       = module.vpc.security_group_id
}

output "instance_id" {
  description = "ID of the EC2 instance in the dev environment."
  value       = module.ec2.instance_id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance."
  value       = module.ec2.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance."
  value       = module.ec2.public_dns
}
