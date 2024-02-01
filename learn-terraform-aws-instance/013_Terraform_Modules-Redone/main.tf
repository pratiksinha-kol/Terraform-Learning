terraform {

}

module "apache-module-demo" {
  source        = ".//terraform-aws-apache-module-demo"
  instance_type = "t2.micro"
  vpc_id        = "vpc-04560e2c74ba4b195"
  my_ip_address = "115.187.62.117/32"
  server_name = "Apache Server Module"
}

output "public_ip" {
  value = module.apache-module-demo.public_ip
}

output "private_ip" {
  value = module.apache-module-demo.private_ip
}