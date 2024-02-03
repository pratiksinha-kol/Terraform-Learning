terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.33.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami 
data "aws_ami" "packer_image" {
  #   executable_users = ["self"]
  #   most_recent      = true
  #   name_regex       = "^apache-ami-*"
  owners = ["self"]

  filter {
    name   = "name"
    values = ["apache-ami-1706980136"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "my-http" {
  ami           = data.aws_ami.packer_image.id
  instance_type = "t2.micro"

  tags = {
    Name   = "My Apache Instance"
    Env    = "My Environment ${local.Env}"
    Status = "${local.Name}"
  }
}


locals {
  Env  = "Dev"
  Name = "Image from Packer"
}

output "public_ip" {
  value = aws_instance.my-http.public_ip
}

output "private_ip" {
  value = aws_instance.my-http.private_ip
}