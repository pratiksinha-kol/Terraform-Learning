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

### Standard S3 backend
https://developer.hashicorp.com/terraform/language/settings/backends/s3 

It is recommended to enable versioning on the bucket beforehand as the Terraform State keeps on changing. 

```
terraform {

  backend "s3" {
    // Bucket name
    bucket = "terraform-backend-psh"
    // State file
    key    = "backend/state_file/terraform.tfstate"
    region = "us-east-1"
  }
}
```

### Multiple Workspace S3 backend

```
terraform workspace
```

Show the list of workspaces
```
terraform workspace list
```

Create a new workspaces, (`staging` the name of new workspace)

```
terraform workspace new staging
```

#### Delegating Access
https://developer.hashicorp.com/terraform/language/settings/backends/s3 

Use conditional configuration to pass a different assume_role value to the AWS provider depending on the selected workspace. For example:

```hcl
variable "workspace_iam_roles" {
  default = {
    staging    = "arn:aws:iam::STAGING-ACCOUNT-ID:role/Terraform"
    production = "arn:aws:iam::PRODUCTION-ACCOUNT-ID:role/Terraform"
  }
}

provider "aws" {
  # No credentials explicitly set here because they come from either the
  # environment or the global credentials file.

  assume_role = {
    role_arn = "${var.workspace_iam_roles[terraform.workspace]}"
  }
}

```
## 
Rectify `git push` issue: 
```
$ git pull origin main --allow-unrelated-histories
```