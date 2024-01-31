terraform {

}

module "apache_module_example" {
  source          = ".//terraform-aws-module-apache-example"
  ami             = "ami-0c0b74d29acd0cd97"
  instance_type   = "t2.micro"
  vpc_id          = "vpc-04560e2c74ba4b195"
  my_ip_cidr_ipv4 = "115.187.62.117/32"
}

output "public_ip" {
  value = module.apache_module_example.public_ip
}

output "private_ip" {
  value = module.apache_module_example.private_ip
}