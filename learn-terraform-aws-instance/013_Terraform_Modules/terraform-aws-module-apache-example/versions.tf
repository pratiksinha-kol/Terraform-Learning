terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.33.0"
    }
  }
}

/* In the provider section, do not use profile flag, especially if you are planning to use/run it remotely. 
You can it when running it locally. 
Hence, [# profile = "default"] is not being added. See below for proof
 */
provider "aws" {
  region = "us-east-1"
  alias  = "east"
}