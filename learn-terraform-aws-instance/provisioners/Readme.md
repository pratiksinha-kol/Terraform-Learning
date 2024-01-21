### Terraform Provider Configuration (Usually under main.tf)

```
provider "aws" {
  region = "us-east-1"
}

```

https://spacelift.io/blog/terraform-aws-provider
https://developer.hashicorp.com/terraform/language/providers/configuration 



### Data Sources in Terraform
Data sources allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.

https://developer.hashicorp.com/terraform/language/data-sources 

```
data "aws_ami" "example" {
  most_recent = true

  owners = ["self"]
  tags = {
    Name   = "app-server"
    Tested = "true"
  }
}
```

```
data "aws_vpc" "selected" {
  id = var.vpc_id
}
```

### Key pair to access to your EC2 instance

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair

```
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}
```

As mentioned here, you need to have _a key name_ and _a public key_. 
To generate public/private key you need to run `ssh-keygen`

https://docs.acquia.com/cloud-platform/manage/ssh/getting-started-ssh/generate/
https://www.servers.com/support/knowledge/linux-administration/how-to-create-a-new-ssh-key-pair 

In this example, we are using 
```
ssh-keygen -t rsa
```
- Enter the file name where to save the key `terraform or anything else i.e. /c/Users/PRATIK\ SINHA/.ssh/terraform`
- Passphrase if required (I am leaving it empty)
- Reenter the passphrase

A public key and a private key would be generated. copy the content of the public key (ends with .pub) and use it in the public_key as mentioned in the `aws_key_pair` resource. 

I used Putty to login into my EC2 (generate a .ppk file beforehand)

### Provisioners

#### local-exec Provisioner

https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec 

```
 provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
```
#### remote-exec Provisioner

https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec

```
  provisioner "remote-exec" {
    inline = [
      "echo ${self.private_ip} >> /home/ec2-user/private_ips.txt"
    ]
  }
```

This command will only apply updates on the AWS EC2 Resource
`terraform apply -replace="aws_instance.server"`

#### file Provisioner 



#### Connection for provisioners (remote-exe and file)

https://developer.hashicorp.com/terraform/language/resources/provisioners/connection 

```
connection {
    type     = "ssh"
    user     = "root"
    password = "${var.root_password}"
    host     = "${var.host}"
  }
```

I had created a private key before hand, my connection is as follows:

```
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/.ssh/terraform")
    host        = self.public_ip
  }
```

### Null Resource

https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource 

The null_resource resource implements the standard resource lifecycle but takes no further action. On Terraform 1.4 and later, use the terraform_data resource type instead

