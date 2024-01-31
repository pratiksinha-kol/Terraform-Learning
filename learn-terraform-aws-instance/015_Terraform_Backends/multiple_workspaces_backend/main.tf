// https://developer.hashicorp.com/terraform/language/settings/backends/s3

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.33.0"
    }
  }

  backend "s3" {
    // Bucket name
    bucket = "terraform-backend-psh"
    // State file
    key    = "backend/state_file/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region      = "us-east-1"
  // Using Workspace based on set variables
  //assume_role = var.workspace_iam_roles[terraform.workspace]
}



//S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket
}

/* resource "aws_s3_bucket_versioning" "bucket" {
  bucket = var.bucket
  versioning_configuration {
    status = "Enabled"
  }
} */


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
  value = module.module-apache-example.public_ip
}

output "private_ip" {
  value = module.module-apache-example.private_ip
}


output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}

/* output "bucket_name" {
  value = aws_s3_bucket_versioning.bucket.id
} */