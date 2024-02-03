packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "ami" {
  type    = string
  default = "ami-0c0b74d29acd0cd97"
}

locals {
  app_name = "Apache Server"
}

source "amazon-ebs" "httpd" {
  source_ami    = var.ami
  instance_type = "t2.micro"
  ami_name      = "apache-ami-{{timestamp}}"
  region        = "us-east-1"
  ssh_username  = "ec2-user"
  tags          = {
    Name = "My ${local.app_name}"
    }
}

build {
  name = "apache-aws-image"
  sources = [
    "source.amazon-ebs.httpd"
  ]

  provisioner "shell" {
    inline = [
      "echo Installing Apache",
      "sleep 10",
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
    ]
  }

}
