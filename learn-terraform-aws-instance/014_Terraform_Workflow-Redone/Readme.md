# Team Workflows

https://developer.hashicorp.com/terraform/intro/core-workflow 

**VCS (Version Control Systems)** 

1. Create a new private repository, mine is `vcs-terraform`. Perform git initialization and other functions.  

```
git init

git add .

git commit -m "first commit"

git branch -M main

git remote add origin https://github.com/pratiksinha-kol/vcs-terraform.git

git push -u origin main
```

2. Go to Terraform Cloud and create a new `Workspace`. Opt for **`Version Control Workflow`**. 
Only give permission to the repository that you have just created. Don't give permission for all your repository. 

# vcs-terraform

In the main.tf file, ensure the version that is being used is latest. As mentioned above, the `Workspace` is using the main branch, so whenever any commit is made to it `terraform plan` will be executed.  

### Using Pull request to run the terraform plan

- First create a new branch from where a pull request can be made 
`git checkout -b s3_bucket` 
- See head by running `git branch`
- Make some changes, I have added S3 bucket resource
- Add these changes by performing `git add`, `git commit` and `git push`
- Go to Github page of the working repository (mine is `vcs-terraform`), and click on **Compare and Pull Request** 
- Whenever, there is any kind of change in the `main` branch, `terraform plan` will be executed. If you want to perform `terraform apply` automatically without giving manual permission, go to the _Setting_ section of the _Terraform Cloud Workspace_ and select the behaviour accordingly. 
