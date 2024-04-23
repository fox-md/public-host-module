terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

variable "length" {
  type    = number
  default = 2
}

resource "random_pet" "name" {
  length = var.length
}

output "name" {
  value = random_pet.name.id
}
