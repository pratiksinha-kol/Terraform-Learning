variable "ami" {
  type        = string
  description = "AMI for your EC2 INSTANCE"
}

variable "instance_type" {
  type        = string
  description = "Choose your favorite instance i.e. t2.micro/t2.small/t2.medium"
}

variable "vpc_id" {
  type        = string
  description = "Fetch your VPC ID fro AWS Console"
}

variable "my_ip_cidr_ipv4" {
  type        = string
  description = "Your own IP address in the format xx.xx.xx.xx/32"
}

variable "bucket" {
  type        = string
  description = "Terraform S3 bucket name"
  default     = "terraform-bucket-for-workflow-example"
}

// For Terraform Workspace
variable "workspace_iam_roles" {
  default = {
    staging    = "arn:aws:iam::STAGING-ACCOUNT-ID:role/Terraform"
    production = "arn:aws:iam::PRODUCTION-ACCOUNT-ID:role/Terraform"
  }
}