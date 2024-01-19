output "private_ip" {
  value = aws_instance.server.private_ip
  description = "The private IP address of the main server instance."
}

output "public_ip" {
  value = aws_instance.server.public_ip
  description = "The public IP address of the main server instance."
}

/* output "vpc_id" {
  value = module.vpc.vpc_id
} */

output "owner" {
  value = "Owner of the sample project is ${local.owner}"
}