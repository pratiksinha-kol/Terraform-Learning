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


variable "instance_type" {
  type    = string
  //default = "t4.micro"
  //sensitive = true
  description = "The size of EC2 Instance"
    validation {
    condition     = can(regex("^t2.",var.instance_type))
    error_message = "The instance id must start with \"t2.\""
  }
}

variable "ami_list" {
  type    = string
  //default = "ami-0c0b74d29acd0cd97"
  // ("ami-0005e0cfe09cc9050", "ami-02aead0a55359d6ec")
  description = "Provide AMI for the EC2 Instance"
  validation {
    condition     = length(var.ami_list) > 5 && substr(var.ami_list, 0, 4) == "ami-"
    error_message = "The AMI Image ID value must be a valid AMI id, starting with \"ami-\"."
  }
}

// DATA SOURCE
// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = "MyInstance-${local.project_name}"
    Owner = "${local.owner}"
  }
}

locals {
  project_name = "terraform-variable-outputs"
  owner        = "Pratik Sinha"
}

output "private_ip" {
  value       = aws_instance.server.private_ip
  description = "The private IP address of the main server instance."
  sensitive = true
}

output "public_ip" {
  value       = aws_instance.server.public_ip
  description = "The public IP address of the main server instance."
}
