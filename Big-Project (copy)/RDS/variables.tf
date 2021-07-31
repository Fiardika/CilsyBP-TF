variable "aws_access_key" {
  default = "xxxxxxxxxxxxxxxxxxxxxxx"
}

variable "aws_secret_key" {
  default = "xxxxxxxxxxxxxxxxxxxxxxxxx"
}

variable "region" {
  default = "ap-southeast-1"
}

variable "identifier" {
  default = "bigprodb"
}

variable "allocated_storage" {
  default = 20
}

variable "engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "5.7.34"
}

variable "instance_class" {
  default = "db.t3.micro"
}

variable "username" {
  default = "admin"
}

variable "password" {
  default = "password"
}

variable "parameter_group_name" {
  default = "default.mysql5.7"
}

variable "vpc_security_group_ids" {
  default = ["sg-04beb31b00c1c9682"]
}