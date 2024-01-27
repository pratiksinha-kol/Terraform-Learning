data "aws_ami" "east-amazon-linux-2" {
  most_recent = true
  //owners      = ["amazon"]
  provider = aws.east

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "template_file" "user_data" {
  template = file("${abspath(path.module)}/userdata.yml")
}

resource "aws_instance" "server" {
  ami                    = data.aws_ami.east-amazon-linux-2.id
  instance_type          = var.instance_type
  //key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow_http_tls.id]
  user_data              = data.template_file.user_data.rendered


/*   connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/.ssh/terraform")
    host        = self.public_ip
  } */


  tags = {
    Name = "MyInstance-${local.project_name}"
    Env  = local.env
  }
}

// Using this key during EC2 instance creation by referencing key_name
/* resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.public_key
} */

data "aws_vpc" "main" {
  id = var.vpc_id
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
  cidr_ipv4         = var.my_ip_cidr_ipv4
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.allow_http_tls.id
  cidr_ipv6         = "::/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

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


locals {
  project_name = "Terraform-Modules"
  env          = "Apache Server Example"
}