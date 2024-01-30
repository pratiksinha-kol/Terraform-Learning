terraform {
  cloud {
    organization = "pratiksinha-org"

    workspaces {
      name = "vcs-terraform"
    }
  }
}


module "apache_module_example" {
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
  value = module.apache_module_example.private_ip
}