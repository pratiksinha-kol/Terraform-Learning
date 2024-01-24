# Terraform-lab



### terraform fmt
To format the main.tf


### terraform validate
To validate rge main.tf

### terraform init

Initialize the provider, it can be AWS Azure of GCP. After running this command, you will notice 2 files being created .terraform and lock file. 

### terraform plan & apply


### Input Variables
https://developer.hashicorp.com/terraform/language/values/variables 
https://jamesmiller.blog/terraform-variable-types/

```
variable "instance_list" {
  type = list("t2.micro", "t4.micro")
  default = "t3.micro"
}
```

#### For custom variables CLI

```
tf plan -var=instance_type=t3.micro
```


### Template String interpolation

https://developer.hashicorp.com/terraform/language/expressions/strings

```
$${	Literal ${, without beginning an interpolation sequence.
%%{	Literal %{, without beginning a template directive sequence.
```

### Terraform Module

Whenever using a module, you need to use `terraform init` **ALWAYS**

### List Terraform workspace

`tf workspace list`

### Migrate state to Terraform Cloud

https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-migrate#configure-terraform-cloud-integration

```tf
  cloud {
    organization = "pratiksinha-org"

    workspaces {
      name = "learn-terraform-cloud-migrate"
    }
  }
}
```

### 

