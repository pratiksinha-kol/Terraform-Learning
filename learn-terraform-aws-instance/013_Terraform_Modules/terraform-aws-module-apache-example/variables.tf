variable "ami" {
  type    = string
  default = "true"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "vpc_id" {
  type = string
}

variable "my_ip_cidr_ipv4" {
  type        = string
  description = "PROVIDE YOUR IP i.e. xxx.xxx.xxx.xxx/32"
}
