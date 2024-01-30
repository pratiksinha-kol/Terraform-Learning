## Terraform Backends

https://developer.hashicorp.com/terraform/language/settings/backends/configuration 

A backend defines where Terraform stores its state data files.

### How to set Terraform backend configuration dynamically 

https://brendanthompson.com/posts/2021/10/dynamic-terraform-backend-configuration

You can utilise a `backend.hcl` file and pass that into the Terraform init command. Here is an an example of it. 

```hcl
hostname     = "app.terraform.io"
organization = "ministry-of-magic"
workspaces { Name = "sorting-hat-api-prod" }
```

The following command consumes the above configuration:

```hcl
terraform init -backend-config=backend.hcl
```


#### The terraform_remote_state Data Source
https://developer.hashicorp.com/terraform/language/state/remote-state-data 

The `terraform_remote_state` data source uses the latest state snapshot from a specified state backend to retrieve the root module output values from some other Terraform configuration.

You can use the `terraform_remote_state` data source without requiring or configuring a provider.

```hcl
data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "hashicorp"
    workspaces = {
      name = "vpc-prod"
    }
  }
}

# Terraform >= 0.12
resource "aws_instance" "foo" {
  # ...
  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id
}

# Terraform <= 0.11
resource "aws_instance" "foo" {
  # ...
  subnet_id = "${data.terraform_remote_state.vpc.subnet_id}"
}
```