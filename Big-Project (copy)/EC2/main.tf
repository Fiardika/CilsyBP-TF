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

resource "aws_instance" "control_plane" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  associate_public_ip_address = var.associate_public_ip_address
  count                       = var.instance_count
  availability_zone           = var.availability_zone

  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.root_volume_size
    delete_on_termination = var.delete_on_termination
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = {
    Name = var.tags["name"]
  }

  volume_tags = {
    Name = var.tags["name"]
  }

  provisioner "file" {
    source      = "installation.sh"
    destination = "/tmp/installation.sh"
  }

  provisioner "file" {
    source      = "cluster.sh"
    destination = "/tmp/cluster.sh"
  }
  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/fiardika/key-pair/key.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "ssh-keygen -t rsa -f /home/ubuntu/.ssh/id_rsa -q -P ''",
      "chmod +x /tmp/installation.sh",
      "chmod +x /tmp/cluster.sh",
      ". /tmp/installation.sh",
      ". /tmp/cluster.sh"
    ]

    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/fiardika/key-pair/key.pem")
    }
  }
}