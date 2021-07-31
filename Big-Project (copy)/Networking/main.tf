terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 1.0.2"
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  profile    = "default"
  region     = var.region
}

resource "aws_vpc" "bigpro_vpc" {
  cidr_block           = "192.168.0.0/24"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "bigpro-vpc"
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.bigpro_vpc.id
  cidr_block              = "192.168.0.0/27"
  map_public_ip_on_launch = "true"
  availability_zone       = var.availability_zone[0]

  tags = {
    Name = "public-subnet-a"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.bigpro_vpc.id
  cidr_block              = "192.168.0.32/27"
  map_public_ip_on_launch = "true"
  availability_zone       = var.availability_zone[1]

  tags = {
    Name = "public-subnet-b"
  }
}

resource "aws_internet_gateway" "bigpro_igw" {
  vpc_id = aws_vpc.bigpro_vpc.id

  tags = {
    Name = "bigpro-igw"
  }
}

resource "aws_route_table" "bigpro_route_table" {
  vpc_id = aws_vpc.bigpro_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bigpro_igw.id
  }

  tags = {
    Name = "bigpro-route-table"
  }
}
resource "aws_main_route_table_association" "bigpro_main_route" {
  vpc_id         = aws_vpc.bigpro_vpc.id
  route_table_id = aws_route_table.bigpro_route_table.id
}

resource "aws_route_table_association" "assoc_public_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.bigpro_route_table.id
}

resource "aws_route_table_association" "assoc_public_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.bigpro_route_table.id
}

resource "aws_security_group" "big_pro_sg" {
  description = "Security Group for Big Project"
  vpc_id      = aws_vpc.bigpro_vpc.id

  ingress {
    description = "open all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Big-Pro-SG"
  }
}