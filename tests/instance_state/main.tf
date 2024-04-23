variable "instance_id" {
  type = string
}

data "aws_instance" "this" {
  instance_id = var.instance_id
}

output "instance_state" {
  value = data.aws_instance.this.instance_state
}
