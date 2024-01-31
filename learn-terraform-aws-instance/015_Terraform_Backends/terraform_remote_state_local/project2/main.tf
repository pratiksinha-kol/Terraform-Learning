// https://developer.hashicorp.com/terraform/language/state/remote-state-data

data "terraform_remote_state" "vpc" {
  backend = "local"
  // Location of the file
  config = {
    path = "../project1/terraform.tfstate"
  }
}

module "module-apache-example" {
  //source          = "pratiksinha-kol/module-apache-example/aws"
  source          = "../../../013_Terraform_Modules/terraform-aws-module-apache-example"
  //version         = "1.0.4"
  ami             = var.ami
  instance_type   = var.instance_type
  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
  my_ip_cidr_ipv4 = var.my_ip_cidr_ipv4
}

output "public_ip" {
  value = module.module-apache-example.public_ip
}

output "private_ip" {
  value = module.module-apache-example.private_ip
}

output "vpc_id" {
  value = data.terraform_remote_state.vpc.outputs.vpc_id
}