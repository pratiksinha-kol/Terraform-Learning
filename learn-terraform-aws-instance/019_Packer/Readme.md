## Packer

https://developer.hashicorp.com/packer/docs?product_intent=packer 
https://github.com/cohenaj194/apache-packer/tree/master 

### Creating an Image

The name of the image which will be build by Packer needs to be in `*.pkr.hcl`. 

The sample code is provided below: 

```hcl
packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "ami" {
  type    = string
  default = "ami-0c0b74d29acd0cd97"
}

locals {
  app_name = "Apache Server"
}

source "amazon-ebs" "httpd" {
  source_ami    = var.ami
  instance_type = "t2.micro"
  ami_name      = "apache-ami-{{timestamp}}"
  region        = "us-east-1"
  ssh_username  = "ec2-user"
  tags          = {
    Name = "My ${local.app_name}"
    }
}

build {
  name = "apache-aws-image"
  sources = [
    "source.amazon-ebs.httpd"
  ]

  provisioner "shell" {
    inline = [
      "echo Installing Apache",
      "sleep 10",
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
    ]
  }
}
```

Before building an image, you need to initialize beciase it requires plug-in (in our case AWS)

```
 packer init FILE_NAME.pkr.hcl or  packer init . 
```

Validate your template(mine is `apache.pkr.hcl`)

```
packer validate FILE_NAME.pkr.hcl 
```

Build your image (Using the above file):

```
packer build apache.pkr.hcl 
```

If there are no errors, an AMI Image would be created and can be found under `AMI` Section of the `AWS`. 

### Using the generated AMI Image from Packer

Check the `main.tf` file and see how it is being provisioned. We have used [data source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami 
) to import the image. 


