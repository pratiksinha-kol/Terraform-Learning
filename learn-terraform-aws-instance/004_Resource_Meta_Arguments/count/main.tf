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
  count         = 2

  tags = {
    Name  = "MyInstance-${count.index}"
    Owner = "${local.owner}"
    Env   = "MyInstance-${local.project_name}"
  }
}

/* resource "aws_s3_bucket" "s3_bucket" {
  bucket = "my-tf-test-bucket-psh-${count.index}"
  count = 4
} */

locals {
  project_name = "terraform-meta-arguments-count"
  owner        = "Pratik Sinha"
}

output "private_ip" {
  // Will Display ONLY 1 OUTPUT
  value       = aws_instance.server[1].private_ip
  description = "The private IP address of the main server instance."
  sensitive   = false
}

output "public_ip" {
  // Will Display ALL OUTPUT  
  value       = aws_instance.server[*].public_ip
  description = "The public IP address of the main server instance."
}
