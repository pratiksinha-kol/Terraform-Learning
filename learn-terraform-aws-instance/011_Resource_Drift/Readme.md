## Resource Drift

https://developer.hashicorp.com/terraform/tutorials/state/resource-drift

It's when your live infrastructure deviates from what's described in your Terraform configuration files. Such deviations can happen in multiple ways. One common cause is changes made outside Terraform's oversight. 

Run `terraform plan -refresh-only` to determine the drift between your current state file and actual configuration.

Run `terraform plan -replace` (it can be used with `terraform apply` as well) to Instructs Terraform to plan to replace the resource instance with the given address. This is helpful when one or more remote objects have become degraded, and you can use replacement objects with the same configuration to align with immutable infrastructure patterns. Terraform will use a "replace" [action](https://developer.hashicorp.com/terraform/cli/commands/plan#replace-address) if the specified resource would normally cause an "update" action or no action at all.

## Resource Addressing

https://developer.hashicorp.com/terraform/cli/state/resource-addressing 

A _resource address_ is a string that identifies zero or more resource instances in your overall configuration.

An address is made up of two parts:
```
[module path][resource spec]
```

## Terraform Import

https://developer.hashicorp.com/terraform/cli/import 

Terraform can import existing infrastructure resources. This functionality lets you bring existing resources under Terraform management. 

Before you run `terraform import` you must manually write a `resource` configuration block for the resource. The resource block describes where Terraform should map the imported object.

Usage: `terraform import [options] ADDRESS ID`

**[SOURCE](https://developer.hashicorp.com/terraform/cli/commands/import)**

Import will find the existing resource from ID and import it into your Terraform state at the given ADDRESS.

Example Import into Resource: 
```
terraform import aws_instance.foo i-abcd1234
```
Example: Import into Module

```
terraform import module.foo.aws_instance.bar i-abcd1234
```

## FOLLOW ALONG

#### Replace Example

You can use it on a single resource
```
terraform apply -replace aws_instance.server
```

#### Refresh-only 

**_Scenario:_** If you have created a EC2 via terraform and deleted that EC2 AWS Console. Terraform had no idea of knowing that the EC2 instance has been terminated. Now, if you run `terraform apply` it will **create** a new resource and even prompt that the resource has been **deleted**. 

![Resource Deleted](/learn-terraform-aws-instance/Images/deleted.PNG)

## 
![Resource Creation](/learn-terraform-aws-instance/Images/creation.PNG)

Now, if you run the following command, it will detect the changes and prompt you the same. 

```
terraform apply -refresh-only 
```

It will ask **Would you like to update the Terraform state to reflect these detected changes?** which will update the state file. If you `approve` it will update the `terraform.tfstate` file. 

#### Terraform import 

https://spacelift.io/blog/importing-exisiting-infrastructure-into-terraform 

For this example, We have created a S3 bucket (terraform-pratik-sinha) manually from AWS Console. Additionally, we have created a S3 resource in the `main.tf` file. 

```
// We have created this S3 bucket manually from AWS Console
// Now we will import it into our infrastructure using `terraform import`
resource "aws_s3_bucket" "import_s3_bucket" {
  bucket = "terraform-pratik-sinha"
}
```
To Import, we will use the following command 
```
terraform import aws_s3_bucket.import_s3_bucket terraform-pratik-sinha
```

![Terraform Import](/learn-terraform-aws-instance/Images/Terraform%20Import.PNG)
