terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}


provider "aws" {
  region = var.aws_region
}


resource "aws_security_group" "sg_22" {
  name   = "connector_hub_terraform_sg"
  vpc_id = var.vpc_id

  # to SSH in
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # to get out
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
  
}

resource "aws_instance" "web" {
  ami                         = "ami-007855ac798b5175e"
  subnet_id                   = var.subnet_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.sg_22.id]
  associate_public_ip_address = true

  tags = {
    Name = "connector-hub-testing"
  }
  root_block_device {
    volume_size = 100
  }
  # connection {
  #   host        = self.public_ip
  #   user        = "ubuntu"
  #   type        = "ssh"
  #   private_key = file(var.private_key_path)
  #   timeout     = "5m"
  # }

    user_data = file("../scripts/connector-hub.sh")
}

output "instance_ip_addr" {
  value = aws_instance.web.public_dns
}


output  "private_dns" {
  value = aws_instance.web.private_dns
}