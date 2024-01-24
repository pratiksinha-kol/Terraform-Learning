variable "instance_type" {
  type    = string
  default = "t4.micro"
}

variable "ami_list" {
  type    = string
  default = "ami-0c0b74d29acd0cd97"
  // ("ami-0005e0cfe09cc9050", "ami-02aead0a55359d6ec")
}

