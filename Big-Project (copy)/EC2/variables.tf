variable "aws_access_key" {
  default = "xxxxxxxxxxxxxxx"
}

variable "aws_secret_key" {
  default = "xxxxxxxxxxxxxxxxx"
}

variable "region" {
  default = "ap-southeast-1"
}

variable "ami" {
  default = "ami-0d058fe428540cd89"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "key_name" {
  default = "key"
}

variable "subnet_id" {
  default = "subnet-04c69649e2789633d"
}

variable "vpc_security_group_ids" {
  default = ["sg-04beb31b00c1c9682"]
}

variable "associate_public_ip_address" {
  default = true
}

variable "instance_count" {
  default = 1
}

variable "availability_zone" {
  default = "ap-southeast-1a"
}

variable "volume_type" {
  default = "gp2"
}

variable "root_volume_size" {
  default = 30
}

variable "delete_on_termination" {
  default = true
}

variable "volume_size" {
  default = 8
}

variable "tags" {
  type = map(string)
  default = {
    "name" = "Control Plane"
  }
}