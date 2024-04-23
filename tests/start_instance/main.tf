variable "instance_id" {
  type = string
}

resource "aws_ec2_instance_state" "this" {
  instance_id = var.instance_id
  state       = "running"
}
