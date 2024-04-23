ubuntu_version = "22.04"
key_name       = "2024"
vpc_id         = "vpc-ed026485"
domain_name    = "gumeniuc.me"
name           = "module-testing"
http_protocol  = "http"

ingress_rules = {
  http = {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

egress_rules = {
  all = {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
