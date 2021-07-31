terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 1.0.2"
}

provider "aws" {
  access_key = "xxxxxxxxxxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxxxxxxx"
  profile    = "default"
  region     = "ap-southeast-1"
}

resource "aws_s3_bucket" "big_pro_bucket" {
  bucket = "k8s-bigpro"
  acl    = "private"
  versioning {
    enabled = false
  }

  tags = {
    Name = "k8s-bigpro"
  }
}