

variable "ami" {
  type        = string
  description = "AMI for your EC2"
}

variable "instance_type" {
  type        = string
  description = "Type of your instance"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where you want to launch your EC2 Instance"
}

variable "my_ip_cidr_ipv4" {
  type        = string
  description = "Your own IP address in the format xx.xx.xx.xx/32"
}