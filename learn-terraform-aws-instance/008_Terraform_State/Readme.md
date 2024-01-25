## Terraform State

https://developer.hashicorp.com/terraform/language/state 

https://spacelift.io/blog/terraform-state

State is a particular condition of a cloud resource at a specific time. The state file is an artifact that you're left with once an Infrastructure as Code framework finishes a deployment. 


Terraform logs information about the resources it has created in a state file (snapshot of a state). The terraform state file, by default, is named `terraform.tfstate` and is held in the same directory where Terraform is run. It is created after running terraform apply. 

The actual content of this file is a JSON formatted mapping of the resources defined in the configuration and those that exist in your infrastructure.

**It is not a good idea to store the state file in source control. This is because Terraform state files contain all data in plain text, which may contain secrets.**

| COMMAND | EXPLANATION|
|----------------------------------|------------------------------------------------|
| `terraform state list`             | List resources in the state |
| `terraform state mv`               | Move an item in the state | 
| `terraform state pull`             | Pull current remote state and output to stdout |
| `terraform state rm`               | Remove instances from the state |
| `terraform state push`             | Update remote state from a local state | 
| `terraform state replace provider` | Replace provider in the state | 
| `terraform state show`             | Show a resources in the state |

## 

`terraform state mv` is helpful in many situations:
- rename existing situations `terraform state mv packet_device.worker packet_device.helper`
- move a resource into a module `terraform state mv packet_device.worker module.worker.packet_device.worker`
- move a module into a module `terraform state mv module.app module.parent.module.app`

https://developer.hashicorp.com/terraform/cli/commands/state/mv

### Terraform State Backup

The terraform.tfstate.backup file is a backup of the terraform.tfstate file. Terraform automatically creates a backup of the state file before making any changes to the state file. This ensures that you can recover from a corrupted or lost state file. You can use the terraform.tfstate.backup file to restore your Terraform state to a previous version. To do this, simply rename the `terraform.tfstate.backup` file to `terraform.tfstate` and run `terraform init`.

Here are some reasons why you might need to restore your Terraform state from a backup:

- If the terraform.tfstate file is corrupted or lost.
- If you accidentally delete a resource from Terraform management.
- If you need to revert to a previous version of your infrastructure.

Backup of the state file is stored in `terraform.tfstate.backup`. It is **Created** automatically before Terraform makes any changes to the state file and **Overwritten** every time Terraform makes changes to the state file. Stored in the same directory as the state file

https://www.devopsschool.com/blog/what-is-terraform-tfstate-backup-file-in-terraform/#terraformtfstatebackup 

### Terraform State CLI

| COMMAND |  EXAMPLE |
| :----- | ----: |
| `terraform state list` | Outputs resources i.e. `aws_instance.server` | 
| `terraform state mv` | Helpful in renaming (mention old resource name and then new resource name) `tf state mv aws_instance.server aws_instance.my_server`  |
| `terraform state show` | Show information about the resources `tf state show aws_instance.server` |



