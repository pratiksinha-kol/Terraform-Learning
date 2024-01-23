terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.33.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

provider "aws" {
  region = "us-west-1"
  alias  = "west"
}

provider "aws" {
  region = "us-east-2"
  alias  = "east"
}

data "aws_ami" "east-amazon-linux-2" {
  most_recent = true
  //owners      = ["amazon"]
  provider    = aws.east

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "aws_ami" "west-amazon-linux-2" {
  most_recent = true
  //owners      = ["amazon"]
  provider    = aws.west

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "east_server" {
  //ami           = "ami-09694bfab577e90b0"
  ami           = "${data.aws_ami.east-amazon-linux-2.id}"
  instance_type = "t2.micro"
  provider      = aws.east

  tags = {
    Name  = "MyInstance-East-Server"
    Owner = "${local.owner}"
    Env   = "MyInstance-${local.project_name}"
  }
}

resource "aws_instance" "west_server" {
  //ami           = "ami-0353faff0d421c70e"
  ami           = "${data.aws_ami.west-amazon-linux-2.id}"
  instance_type = "t2.micro"
  provider      = aws.west

  tags = {
    Name  = "MyInstance-West-Server"
    Owner = "${local.owner}"
    Env   = "MyInstance-${local.project_name}"
  }
}

locals {
  project_name = "terraform-meta-arguments-alias"
  owner        = "Pratik Sinha"
}

output "east_private_ip" {
  value       = aws_instance.east_server.private_ip
  description = "The private IP address of the east server instance."
  sensitive   = false
}

output "west_private_ip" {
  value       = aws_instance.west_server.private_ip
  description = "The private IP address of the west server instance."
  sensitive   = false
}

output "east_public_ip" {
  value       = aws_instance.east_server.public_ip
  description = "The public IP address of the east server instance."
}

output "west_public_ip" {
  value       = aws_instance.west_server.public_ip
  description = "The public IP address of the west server instance."
}
