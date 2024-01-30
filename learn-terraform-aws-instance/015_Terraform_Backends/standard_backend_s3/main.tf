// https://developer.hashicorp.com/terraform/language/settings/backends/s3

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
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
  region = "us-east-1"
}

//Watch from 8:23:25