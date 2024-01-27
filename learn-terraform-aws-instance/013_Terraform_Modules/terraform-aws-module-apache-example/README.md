# Terraform module to provision EC2 Instance with user data running on Apache

#### Not recommended for Production Usage. It shows an example of creating custom module on Terraform Registry. 

### Inclusion of module

In the `main.tf`, we will include module. 

```hcl
terraform {

}

module "apache_module_example" {
  source        = ".//terraform-aws-module-apache-example"
  ami           = "ami-0000000000"
  instance_type = "t2.micro"
  vpc_id        = "vpc-000000000000"
  my_ip_cidr_ipv4 = "xxx.xxx.xxx.xxx/32"
}

output "public_ip" {
  value = module.apache_module_example.public_ip
}

output "private_ip" {
  value = module.apache_module_example.private_ip
}
```



## Authors

Module managed by **[Pratik Sinha](https://github.com/pratiksinha-kol)**.

## License

Apache 2 Licensed. See LICENSE for full details.