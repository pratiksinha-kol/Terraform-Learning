terraform {
  
}

variable "str" {
  type = string
  default = "@Earthlings, Death!"
}

variable "random" {
  type = list
  default = [null, null, "Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn"]
}

variable "assorted" {
  type = map
  default = {
    "Kolkata" = "WB"
    "Lucknow" = "UP"
    "Bhopal" = "MP"
    "Chennai" = "TN"
  }
}