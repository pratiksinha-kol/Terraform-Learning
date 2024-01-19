resource "aws_instance" "server" {
  //ami           = "ami-0c0b74d29acd0cd97"
  ami           = var.ami_list
  instance_type = var.instance_type

  tags = {
    Name = "MyInstance-${local.project_name}"
  }
}

/* 
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "terraform-custom-vpc"
  cidr = "10.16.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  private_subnets = ["10.16.0.0/20", "10.16.16.0/20", "10.16.32.0/20", "10.16.48.0/20"]
  public_subnets  = ["10.16.64.0/20", "10.16.80.0/20", "10.16.96.0/20", "10.16.112.0/20"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
 */