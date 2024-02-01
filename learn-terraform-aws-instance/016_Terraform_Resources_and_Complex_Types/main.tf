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
