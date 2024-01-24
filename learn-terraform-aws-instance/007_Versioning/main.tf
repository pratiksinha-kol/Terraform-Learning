terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      //Semantic Versioning
      version = ">= 5.33.0"
      //As per Terraform Website (HARDCODED)
      //version = "5.33.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}