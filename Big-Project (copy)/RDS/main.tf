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

resource "aws_db_instance" "bigpro_db" {
  identifier             = var.identifier
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = var.username
  password               = var.password
  parameter_group_name   = var.parameter_group_name
  skip_final_snapshot    = true
  vpc_security_group_ids = var.vpc_security_group_ids
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.id
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "main"
  subnet_ids = ["subnet-04c69649e2789633d", "subnet-0c329fb529143fb4e"]

  tags = {
    Name = "Big Pro DB Subnet Group"
  }
}