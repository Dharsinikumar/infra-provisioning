resource "aws_vpc" "this" {
  # Creates the main private network boundary for this project.
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-vpc"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_subnet" "public" {
  # Creates the public subnet where internet-facing resources can live.
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-public-subnet"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_subnet" "private" {
  # Creates the private subnet for internal-only resources.
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "${var.aws_region}b"

  tags = {
    Name        = "${var.project_name}-${var.environment}-private-subnet"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_internet_gateway" "this" {
  # Attaches an internet gateway so the VPC can communicate with the internet.
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project_name}-${var.environment}-igw"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_route_table" "public" {
  # Defines routing rules for the public subnet.
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project_name}-${var.environment}-public-rt"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_route" "public_internet_access" {
  # Sends all outbound internet traffic from the public subnet to the internet gateway.
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  # Connects the public subnet to the public route table.
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "web_sg" {
  # Acts as a virtual firewall for instances that need SSH and HTTP access.
  name        = "${var.project_name}-${var.environment}-web-sg"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    # Allows SSH so you can connect to the EC2 instance for administration.
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    # Allows HTTP so nginx can serve web traffic from the instance.
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    # Allows outbound traffic so the instance can reach package repositories and AWS services.
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-web-sg"
    Environment = var.environment
    Project     = var.project_name
  }
}
