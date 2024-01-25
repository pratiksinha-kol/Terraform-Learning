## Terraform Init

https://developer.hashicorp.com/terraform/tutorials/cli/init#review-configuration

When you initialize a Terraform workspace, Terraform configures the backend, installs all providers and modules referred to in your configuration, and creates a version lock file if one doesn't already exist. In addition, you can use the terraform init command to change your workspace's backend and upgrade your workspace's providers and modules.
Usually, it the first step before starting to work with Terraform `terraform init`. 

When you initialize a new Terraform workspace, it creates a lock file named `.terraform.lock.hcl` and the `.terraform` directory. 
- Terraform uses the `.terraform` directory to store the project's `providers` and `modules`. 
- The lock file [`.terraform.lock.hcl`] ensures that Terraform uses the same provider versions across your team and in remote execution environments. During initialization, Terraform will download the provider versions specified by this file rather than the latest versions.

### Terraform init command

https://developer.hashicorp.com/terraform/cli/commands/init

`terraform init [options]`

- `terraform init -upgrade` - Upgrade all previously-selected plugins to the newest version that complies with the configuration's version constraints. This will cause Terraform to ignore any selections recorded in the dependency lock file, and to take the newest available version matching the configured version constraints.

- `terraform init -get-plugins=false` — Skip plugin installation.

- `terraform init -plugin-dir=PATH` — Force plugin installation to read plugins only from the specified directory, as if it had been configured as a filesystem_mirror in the CLI configuration.

- `terraform init -lockfile=MODE` — Set a dependency lockfile mode.

- The `terraform init -migrate-state` option will attempt to copy existing state to the new backend, and depending on what changed, may result in interactive prompts to confirm migration of workspace states.


## Terraform Get

https://developer.hashicorp.com/terraform/cli/commands/get 

The `terraform get` command is used to download and update modules mentioned in the root module. 

It is quite useful in local module development environment as you might need to pull updated  modules but don't want to initiliaze your state or pull new binaries. 

Usage: `terraform get` [options]

The modules are downloaded into a `.terraform` subdirectory of the current working directory. Don't commit this directory to your version control repository.

The `get` command supports the following option:

`-update` - If specified, modules that are already downloaded will be checked for updates and the updates will be downloaded if present.

`-no-color` - Disable text coloring in the output.