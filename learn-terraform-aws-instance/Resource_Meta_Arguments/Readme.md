## Resource Meta Arguments

https://developer.hashicorp.com/terraform/language/meta-arguments/resource-provider 

The provider meta-argument specifies which provider configuration to use for a resource, overriding Terraform's default behavior of selecting one based on the resource type name. Its value should be an unquoted <PROVIDER>.<ALIAS> reference.

### depends_on

https://developer.hashicorp.com/terraform/language/meta-arguments/depends_on

EC2 Instance will be created AFTER the creation of S3 bucket
```
resource "aws_instance" "server" {
  ami           = "ami-0c0b74d29acd0cd97"
  instance_type = "t2.micro"
  depends_on = [ aws_s3_bucket.s3_bucket ]

  tags = {
    Name  = "MyInstance-${local.project_name}"
    Owner = "${local.owner}"
  }
}
```

S3 bucket will be created AFTER the creation of EC2 Instance
```
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "my-tf-test-bucket-psh"
  depends_on = [ aws_instance.server ]

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
```

### count

https://developer.hashicorp.com/terraform/language/meta-arguments/count

`Note: A given resource or module block cannot use both count and for_each.`

```
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "my-tf-test-bucket-psh-${count.index}"
  count = 4
}
```
OUTPUT: `my-tf-test-bucket-psh-0`, `my-tf-test-bucket-psh-1`, `my-tf-test-bucket-psh-2`, `my-tf-test-bucket-psh-3`

#### OUTPUT USING SPLATS

```
output "private_ip" {
  // Will Display ONLY 1 OUTPUT
  value       = aws_instance.server[1].private_ip
  description = "The private IP address of the main server instance."
  sensitive   = false
}

output "public_ip" {
  // Will Display ALL OUTPUT  
  value       = aws_instance.server[*].public_ip
  description = "The public IP address of the main server instance."
}
```

### for_each

https://developer.hashicorp.com/terraform/language/meta-arguments/for_each 

`for_each` is a meta-argument defined by the Terraform language. It can be used with modules and with every resource type.

The `for_each` meta-argument accepts a map or a set of strings, and creates an instance for each item in that map or set. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.

#### The `each` Object

In blocks where `for_each` is set, an additional `each` object is available in expressions, so you can modify the configuration of each instance. This object has two attributes:

- `each.key` — The map key (or set member) corresponding to this instance.
- `each.value` — The map value corresponding to this instance. (If a set was provided, this is the same as each.key.)


### Alias

https://www.devopsschool.com/blog/terraform-tutorials-what-is-namespace-alias/#:~:text=In%20Terraform%2C%20an%20alias%20is,within%20a%20single%20Terraform%20configuration. 

#### Selecting a Non-default Provider Configuration

Data resources **[support](https://developer.hashicorp.com/terraform/language/data-sources)** the provider meta-argument as defined for managed resources, with the same syntax and behavior.

https://developer.hashicorp.com/terraform/language/data-sources 

```
data "aws_ami" "web" {
  provider = aws.west

  # ...
}

```

### Lifecycle

https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle 

