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

// String template
variable "hello" {
  type = string
}

// For Expression (List)
variable "states" {
  type = list(any)
}

// For Expression (Map)
variable "states_capital" {
  type = map(any)
}


// For Expression (Splats)
variable "states_capital_cm_splats" {
  type = list
}
