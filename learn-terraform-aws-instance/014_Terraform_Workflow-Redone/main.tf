terraform {
  cloud {
    organization = "pratiksinha-org"

    workspaces {
      name = "vcs-terraform"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}


//S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket
}


//Latest Version is 1.0.4 is being used
module "module-apache-example" {
  source          = "pratiksinha-kol/module-apache-example/aws"
  version         = "1.0.4"
  ami             = var.ami
  instance_type   = var.instance_type
  vpc_id          = var.vpc_id
  my_ip_cidr_ipv4 = var.my_ip_cidr_ipv4
}

output "public_ip" {
  value = module.apache_module_example.public_ip
}

output "private_ip" {
  value = module.module-apache-example.private_ip
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}