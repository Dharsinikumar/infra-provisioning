data "aws_ami" "amazon_linux_2" {
  # Finds the latest Amazon Linux 2 AMI published by AWS.
  most_recent = true

  owners = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "web" {
  # Launches an EC2 instance to host the nginx web server.
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  user_data = <<-EOF2
              #!/bin/bash
              yum update -y
              amazon-linux-extras install nginx1 -y
              systemctl enable nginx
              systemctl start nginx
              echo "<h1>${var.project_name}-${var.environment} nginx server</h1>" > /usr/share/nginx/html/index.html
              EOF2

  tags = {
    Name        = "${var.project_name}-${var.environment}-ec2"
    Environment = var.environment
    Project     = var.project_name
  }
}
