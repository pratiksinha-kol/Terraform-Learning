terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.33.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "template_file" "user_data" {
  template = file("./userdata.yml")
}

/* Check EC2 Instance Status
https://docs.aws.amazon.com/cli/latest/reference/ec2/wait/instance-status-ok.html#examples  
*/

resource "null_resource" "status" {
  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.server.id}"
  }
  depends_on = [aws_instance.server]
}

resource "aws_instance" "server" {
  //ami           = "ami-0c0b74d29acd0cd97"
  ami                    = "ami-0c0b74d29acd0cd97"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow_http_tls.id]
  user_data              = data.template_file.user_data.rendered


  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/.ssh/terraform")
    host        = self.public_ip
  }

  tags = {
    Name = "MyInstance-${local.project_name}"
  }
}

// Using this key during EC2 instance creation by referencing key_name
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9dlubaj9AZC3zV6naMI95Xf2ZV+GbKCiLvLoT+F/+afQHWchAJCHU0JhsOoELvOUSi5SM2e+L8EKL8UPYmzu9mK8zJG4tt6ypiotTYtFnszMzOKuPGSx6jSX9YmChQGMVpFg7zdZr7zUxNuPUm1a+/BHXPtd8+XKW6JwzqaqGwBZXHIgCgCTNPBvbr/zSJyYasVQxHFhN4XH2FSRXgW8cj7kDncHJYlwpwIKxsHhmDGib0wp+fM1N7nh+M+O4XRZ6Sv0v7KVwpasJY7H4MFELBs1y6zBrniVrmri0VcpbhK3IFACmNSnYfOA8imSJ/T9xYV2Dmgc/2LVlXqhk6agdT+jQzSsMYcmi5S+n5am6g7DeLVQ2owAr4jsSYTuNAp25ZLzEjYiLBy5rLDBvsxS/GSzhCU4CjhBGiHs/NHk2GPvEfBBU/VYzMQognCDXDf+HLIpALl/VovE/kDEmFofwVdn/2A0wyOb7TWVWcEr0QS4bB1gYa8eWJcXnQMC0rYM= PRATIK SINHA@PRATIK-SINHA"
}

data "aws_vpc" "main" {
  id = "vpc-04560e2c74ba4b195"
}


resource "aws_security_group" "allow_http_tls" {
  name        = "allow_http_tls"
  description = "Allow HTTP & TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_http_tls.id
  cidr_ipv4         = data.aws_vpc.main.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.allow_http_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.allow_http_tls.id
  cidr_ipv4         = "115.187.62.117/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

/* resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.allow_http_tls.id
  cidr_ipv6         = data.aws_vpc.main.ipv6_cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
 */

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_http_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_http_tls.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}



output "public_ip" {
  value = aws_instance.server.public_ip
}

output "private_ip" {
  value       = aws_instance.server.private_ip
  description = "The private IP address of the main server instance."
}

locals {
  project_name = "provisioners-example"
}