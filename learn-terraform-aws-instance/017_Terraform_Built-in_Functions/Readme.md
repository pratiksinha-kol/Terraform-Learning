## Built-in Functions

https://developer.hashicorp.com/terraform/language/functions 


### String 

#### Format
```
format("Bye Bye, %s",var.str)
"Hello, ${var.str}"
```
where str = "Humans"

#### Split
```
split (",", "${var.str}")
split ("-", var.str)
split(",", "foo,bar,baz")
```
where str = "Earthlings, Death"

#### Upper, Lower and Title
```
upper (var.str)
lower (var.str)
title(var.str)
```
where str = "Earthlings, Death"

#### Trim, Replace

```
trim (var.str,"@")
replace(var.str,"Death","Welcome")
```
where str = "@Earthlings, Death!"


#### IP Network Functions

```
cidrsubnets("10.1.0.0/16", 4, 4, 4, 4, 4, 4)
cidrsubnets("10.1.0.0/16", 4, 4, 4, 4, 4)

cidrsubnet("172.16.0.0/12", 4, 2)
```

#### Collection Functions

```
coalesce(var.random)
coalesce(var.random...)
```

```
var.assorted
keys(var.assorted)
values(var.assorted)
```

```
reverse([10, 8, 6])
reverse([22, 10, 45])
```

#### File System Function

```
path.root
abspath(path.root)
```
##

_**Visit the link above for more**_
