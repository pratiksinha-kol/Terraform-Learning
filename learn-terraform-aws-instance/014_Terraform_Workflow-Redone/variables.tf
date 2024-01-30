<<<<<<< HEAD


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
=======
variable "ami" {
  type    = string
  description = "AMI for your EC2 INSTANCE"
}

variable "instance_type" {
  type = string
  description = "Choose your favorite instance i.e. t2.micro/t2.small/t2.medium"
}

variable "vpc_id" {
  type = string
  description = "Fetch your VPC ID fro AWS Console"
>>>>>>> 1b4e078719d3ba82686fe39fab66864c70daf70c
}

variable "my_ip_cidr_ipv4" {
  type        = string
<<<<<<< HEAD
  description = "Your own IP address in the format xx.xx.xx.xx/32"
}
=======
  description = "PROVIDE YOUR IP i.e. xx.xx.xx.xx/32"
}

variable "bucket" {
  type        = string
  description = "Terraform S3 bucket name"
  default = "terraform-bucket-for-workflow-example"
}
>>>>>>> 1b4e078719d3ba82686fe39fab66864c70daf70c
