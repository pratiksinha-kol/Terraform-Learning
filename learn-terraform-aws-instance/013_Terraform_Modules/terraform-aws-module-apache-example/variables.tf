variable "ami" {
  type    = string
  default = "true"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "vpc_id" {
  type    = string
  default = "vpc-04560e2c74ba4b195"
}

variable "my_ip_cidr_ipv4" {
  type        = string
  description = "PROVIDE YOUR IP i.e. 115.187.62.117/32"
  default     = "115.187.62.117/32"
}