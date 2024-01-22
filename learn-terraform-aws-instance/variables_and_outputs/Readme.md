## Terraform Variables and Outputs

### Input Variables

https://developer.hashicorp.com/terraform/language/values/variables 

Input variables let you customize aspects of Terraform modules without altering the module's own source code. This functionality allows you to share modules across different Terraform configurations, making your module composable and reusable.

```
variable "image_id" {
  type = string
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["us-west-1a"]
}

variable "docker_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 8300
      external = 8300
      protocol = "tcp"
    }
  ]
}
```

#### Variable Definitions (.tfvars) Files

To set lots of variables, it is more convenient to specify their values in a variable definitions file (with a filename ending in either .tfvars or .tfvars.json) and then specify that file on the command line with -var-file:

```
terraform apply -var-file="testing.tfvars"
```
#### Environment Variables
As a fallback for the other ways of defining variables, Terraform searches the environment of its own process for environment variables named **TF_VAR_** followed by the name of a declared variable.

This can be useful when running Terraform in automation, or when running a sequence of Terraform commands in succession with the same variables. 

##
Terraform also automatically loads a number of variable definitions files if they are present:

Files named exactly **terraform.tfvars** or **terraform.tfvars.json**
Any files with names ending in **.auto.tfvars** or **.auto.tfvars.json**
## 

### Variable Definition Precedence

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

- Environment variables
- The terraform.tfvars file, if present.
- The terraform.tfvars.json file, if present.
- Any `*.auto.tfvars` or `*.auto.tfvars.json` files, processed in lexical order of their filenames.
- Any `-var` and `-var-file` options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)

## 

### Output Values

https://developer.hashicorp.com/terraform/language/values/outputs 

Output values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use. Output values are similar to return values in programming languages.

***Output values have several uses:***

- A child module can use outputs to expose a subset of its resource attributes to a parent module.
- A root module can use outputs to print certain values in the CLI output after running `terraform apply.
- When using [remote state](https://developer.hashicorp.com/terraform/language/state/remote), root module outputs can be accessed by other configurations via a [terraform_remote_state](https://developer.hashicorp.com/terraform/language/state/remote-state-data) data source.

```
output "instance_ip_addr" {
  value = aws_instance.server.private_ip
}
```

### Locals Values

https://developer.hashicorp.com/terraform/language/values/locals 

A local value assigns a name to an expression, so you can use the name multiple times within a module instead of repeating the expression.

**Local values are like a function's temporary local variables.**

```
locals {
  service_name = "forum"
  owner        = "Community Team"
}
```
The expressions in local values are not limited to literal constants; they can also reference other values in the module in order to transform or combine them, including variables, resource attributes, or other local values:

```
locals {
  # Ids for multiple sets of EC2 instances, merged together
  instance_ids = concat(aws_instance.blue.*.id, aws_instance.green.*.id)
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Service = local.service_name
    Owner   = local.owner
  }
}
```

Once a local value is declared, you can reference it in expressions as `local.<NAME>`for usage.

## Data Sources

https://developer.hashicorp.com/terraform/language/data-sources 

_Data sources_ allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.

