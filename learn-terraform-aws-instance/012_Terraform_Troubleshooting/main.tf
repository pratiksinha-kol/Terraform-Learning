terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.33.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_instance" "server" {
  ami           = "ami-0c0b74d29acd0cd97"
  instance_type = "t2.micro"

  tags = {
    Name = "MyInstance-Terraform-Troubleshooting"
  }
}

output "public_ip" {
  value = aws_instance.server.public_ip
  description = "The public IP address of the main server instance."
}