terraform {
}


module "aws_server" {
  source        = ".//aws_server"
  instance_type = "t2.micro"
  ami_list      = "ami-0c0b74d29acd0cd97"
}

output "private_ip" {
  // module.module_name.resource.resource_name
  value       = module.aws_server.private_ip
  description = "The private IP address of the main server instance."
  sensitive   = true
}

output "public_ip" {
  value       = module.aws_server.public_ip
  description = "The public IP address of the main server instance."
}
