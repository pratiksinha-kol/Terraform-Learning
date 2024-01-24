## Version Constraints

https://developer.hashicorp.com/terraform/language/expressions/version-constraints 

Anywhere that Terraform lets you specify a range of acceptable versions for something, it expects a specially formatted string known as a version constraint. Version constraints are used when configuring:

- [Modules](https://developer.hashicorp.com/terraform/language/modules)
- [Provider requirements](https://developer.hashicorp.com/terraform/language/providers/requirements)
- [The required_version setting](https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version) in the `terraform` block.


#### Version Constraint Syntax

```
version = ">= 1.2.0, < 2.0.0"
```
