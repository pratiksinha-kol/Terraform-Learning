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

data "aws_vpc" "main" {
  id = var.vpc_id
}

// This is deprecated (DO NOT USE)
/* data "aws_subnet_ids" "subnet_ids" {
  vpc_id = data.aws_vpc.main.id
} */

// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets 
data "aws_subnets" "subnet_ids" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_instance" "server" {
  ami                    = data.aws_ami.east-amazon-linux-2.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_http_tls.id]
  user_data              = data.template_file.user_data.rendered
  // Need to modify based on the subnet i.e. private or public
  subnet_id                   = tolist(data.aws_subnets.subnet_ids.ids)[0]
  associate_public_ip_address = true

  tags = {
    Name = "MyInstance-${local.project_name}"
    Env  = local.env
  }
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