terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.32.0"
    }
  }

  cloud {
    organization = "pratiksinha-org"

    workspaces {
      name = "learn-terraform-cloud-migrate"
    }
  }
}

locals {
  project_name = "terraform-local-vars"
  owner        = "Pratik Sinha"
}