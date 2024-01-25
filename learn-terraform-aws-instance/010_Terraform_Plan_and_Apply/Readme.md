## Terraform Plan and Apply

### Command: plan

https://developer.hashicorp.com/terraform/cli/commands/plan

The `terraform plan` command creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure. By default, when Terraform creates a plan it:

- Reads the current state of any already-existing remote objects to make sure that the Terraform state is up-to-date.
- Compares the current configuration to the prior state and noting any differences.
- Proposes a set of change actions that should, if applied, make the remote objects match the configuration.

_The `plan` command alone does not actually carry out the proposed changes You can use this command to check whether the proposed changes match what you expected before you apply the changes or share your changes with your team for broader review._

### Command: apply

https://developer.hashicorp.com/terraform/cli/commands/apply 

The `terraform apply` command executes the actions proposed in a Terraform plan.

Usage: `terraform apply [options] [plan file]`

#### Automatic Plan Mode
When you run `terraform apply` without passing a saved plan file, Terraform automatically creates a new execution plan as if you had run [`terraform plan`](https://developer.hashicorp.com/terraform/cli/commands/plan), prompts you to approve that plan, and takes the indicated actions. 

#### Saved Plan Mode
When you pass a saved plan file to `terraform apply`, Terraform takes the actions in the saved plan without prompting you for confirmation. 

To generate a Saved Plan file, use: 
```
terraform plan -out my-saved-plan.plan
``` 

An output with the same name i.e. `my-saved-plan.plan` will be generated out. 

To use this plan, you need this Saved Plan file

```
terraform apply my-saved-plan.plan
```
_FYI: This won't requite `-auto-approve` flag_

However, to destroy the resource, you need a different approcah as `terraform destroy` won't work. Hence, to destroy this resource created with Saved Plan, you need to use

```
terraform apply -destroy -auto-approve
```
