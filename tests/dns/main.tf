variable "host" {
  type = string
}

data "dns_a_record_set" "this" {
  host = var.host
}

output "addrs" {
  value = data.dns_a_record_set.this.addrs
}
