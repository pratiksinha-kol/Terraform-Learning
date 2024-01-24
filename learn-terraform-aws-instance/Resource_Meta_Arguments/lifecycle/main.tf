terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.33.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "server" {
  ami           = "ami-0c0b74d29acd0cd97"
  instance_type = "t2.micro"

  lifecycle {
    //prevent_destroy = true
    prevent_destroy = false
  }


  tags = {
    Name  = "MyInstance-${local.project_name}"
    Owner = "${local.owner}"
    Env   = "MyInstance-${local.project_name}"
  }
}

locals {
  project_name = "terraform-meta-arguments-lifecycle"
  owner        = "Pratik Sinha"
}

output "private_ip" {
  value       = aws_instance.server.private_ip
  description = "The private IP address of the main server instance."
  sensitive   = false
}

output "public_ip" {
  value       = aws_instance.server.public_ip
  description = "The public IP address of the main server instance."
}
