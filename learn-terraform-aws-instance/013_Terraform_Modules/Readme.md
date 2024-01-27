## Terraform Modules

https://developer.hashicorp.com/terraform/language/modules

_Modules_ are containers for multiple resources that are used together. A module consists of a collection of `.tf` and/or `.tf.json` files kept together in a directory.

Modules are the main way to package and reuse resource configurations with Terraform.


### Published Modules
In addition to modules from the local filesystem, Terraform can load modules from a public or private registry. This makes it possible to publish modules for others to use, and to use modules that others have published.

The **[Terraform Registry](https://registry.terraform.io/browse/modules)** hosts a broad collection of publicly available Terraform modules for configuring many kinds of common infrastructure. These modules are free to use, and Terraform can download them automatically if you specify the appropriate source and version in a module call block.

Also, members of your organization might produce modules specifically crafted for your own infrastructure needs. **[Terraform Cloud](https://cloud.hashicorp.com/products/terraform)** and **[Terraform Enterprise](https://developer.hashicorp.com/terraform/enterprise)** both include a private module registry for sharing modules internally within your organization.

### How to Publish Modules on Terraform Registry 

- Go to [Github](https://github.com/), create a new repository. Use the same name as the module. Set it as `Public`.
- After creating a repository on Github, go to the sub-module(or module). Initialize the repository by performing
```
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/profile-name/sub-module-name.git
git push -u origin main
```
- Don't forget to tag your main branch, otherwise you won't be able to publish it on Terraform provider. For that, use these commands:  
```
git tag 1.0.0 or git tag v1.0.0
```

```
git push --tags
```
- To ensure that it has been commited to your GitHub repository, check the main branch or tags. 



- Go to **[Terraform Registry](https://registry.terraform.io/)** and Sign-in using your GitHub account
- On the top right corner, under **Publish**, select Module. There you need to select the appropriate repository which you had for this purpose.    
- After reading Agreement, click on **Publish Module**. 

My published Module on Terraform Registry.
```
https://registry.terraform.io/modules/pratiksinha-kol/module-apache-example/aws/latest
```