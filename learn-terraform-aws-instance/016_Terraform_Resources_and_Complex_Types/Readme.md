## Type Constraints


https://developer.hashicorp.com/terraform/language/expressions/type-constraints


Setting List,Maps, Tuples, and Objects

```
terraform {

}

// List
variable "planet" {
  type = list
  default = ["mars", "earth", "venus", "jupiter"]
}


// Map
variable "names_titles" {
  type = map
  default = {
    "Pratik" = "Sinha"
    "Rima" = "Das"
    "Sonia" = "Menda"
    "Chandan" = "Bera"
  }
}


// Object
variable "plans_object" {
  type = object({
     PlanA = string
     PlanB = string
     PlanC = string
     PlanD = string
  })
  default = {
    "PlanA" = "10 USD"
    "PlanB" = "20 USD"
    "PlanC" = "30 USD"
    "PlanD" = "40 USD"
  }
}


// Object
variable "plan" {
  type = object({
    PlanName = string
    PlanAmount = number
    PlanStatus = bool
  })
  default = {
    PlanName = "Goa"
    PlanAmount = 100
    PlanStatus = true
  }
}

// Tuples
variable "stores" {
  type = tuple([ string, number, bool ])
  default = [ "Arambagh", 224, true ]
}

```

Go to `terraform console`

```hcl
var.names_titles OR var.planets OR var.stores OR var.stores
```

## 

Here are examples of lists, tuples, maps, and objects in Terraform :

1. List - 
An ordered collection of values, accessed by index.
Example : 

```
variable "names" {
 type = list(string)
 default = ["Alice", "Bob", "Charlie"]
}

output "first_name" {
 value = var.names[0] # Access the first element
}
```

2. Tuple - 
An ordered collection of values, like a list, but with fixed size and potentially mixed types.
Example :

```
variable "coordinates" {
 type = tuple([number, number])
 default = [10, 20]
}

output "longitude" {
 value = var.coordinates[0] # Access the longitude
}
```

3. Map - 
An unordered collection of key-value pairs.
Example :

```
variable "tags" {
 type = map(string)
 default = {
 Name = "MyInstance"
 Environment = "Production"
 }
}

output "environment" {
 value = var.tags["Environment"] # Access a value by key
}
```

4. Object
Similar to a map, but with more structure and potentially nested elements.
Example :

```
variable "user" {
 type = object({
 name = string
 email = string
 address = object({
 street = string
 city = string
 })
 })
}

output "user_city" {
 value = var.user.address.city # Access nested properties
}
```
Notes:
Sets are not directly supported in Terraform, but you can often use maps with unique keys to achieve a similar effect.
Terraform doesn't strictly enforce types, but specifying types for variables and arguments is recommended for clarity and consistency.
The for expression can be used to iterate over lists, tuples, maps, and objects.
you can also combine 2 type of data.

Example :

```
variable "ou_to_acount" {
 type = list(object({
 ou_l3 = string
 account = list(object({
 name = string
 email = string
 }))
 }))
}
```