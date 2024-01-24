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
  ami = "ami-0c0b74d29acd0cd97"
  instance_type = each.value
  
  for_each = {
    "nano"   = "t2.nano"
    "micro"  = "t2.micro"
    "medium" = "t2.medium"
    "small"  = "t2.small"
  }

  tags = {
    Name  = "MyInstance-${each.key}"
    Owner = "${local.owner}"
    Env   = "MyInstance-${local.project_name}"
  }
}

locals {
  project_name = "terraform-meta-arguments-for_each"
  owner        = "Pratik Sinha"
}

output "private_ip" {
  value       = values(aws_instance.server)[*].private_ip
  description = "The private IP address of the main server instance."
  sensitive   = false
}

output "public_ip" {
  value       = values(aws_instance.server)[*].public_ip
  description = "The public IP address of the main server instance."
}
