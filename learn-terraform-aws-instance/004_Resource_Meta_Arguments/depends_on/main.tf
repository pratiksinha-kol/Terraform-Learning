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
  depends_on = [ aws_s3_bucket.s3_bucket ]

  tags = {
    Name  = "MyInstance-${local.project_name}"
    Owner = "${local.owner}"
  }
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "my-tf-test-bucket-psh"
  //depends_on = [ aws_instance.server ]

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

locals {
  project_name = "terraform-meta-arguments-depends_on"
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
