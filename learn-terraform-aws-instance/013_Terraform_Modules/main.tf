terraform {

}

module "apache_module_example" {
  source        = ".//terraform-aws-module-apache-example"
  ami           = "ami-0c0b74d29acd0cd97"
  instance_type = "t2.micro"
}

output "public_ip" {
  value = module.apache_module_example.public_ip
}

output "private_ip" {
  value       = module.apache_module_example.private_ip
}