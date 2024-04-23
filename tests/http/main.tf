terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "3.4.0"
    }
  }
}

variable "url" {
  type = string
}

data "http" "index" {
  url      = var.url
  method   = "GET"
  insecure = true
  retry {
    attempts = 10
  }
}

output "response_body" {
  value = data.http.index.response_body
}