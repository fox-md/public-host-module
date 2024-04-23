data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-${var.ubuntu_version}-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "this" {
  name        = var.name
  vpc_id      = var.vpc_id
  description = "${var.name} rules"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.key
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      description = egress.key
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

resource "aws_instance" "this" {
  #checkov:skip=CKV2_AWS_41:No need to attach an IAM role for the moment
  ami                         = data.aws_ami.ubuntu.id
  availability_zone           = "eu-central-1a"
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.this.id]
  associate_public_ip_address = false
  subnet_id                   = "subnet-34fad85c"
  key_name                    = var.key_name

  monitoring    = true
  ebs_optimized = true

  root_block_device {
    encrypted   = true
    volume_size = var.volume_size
  }

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name = var.name
  }
  user_data = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
EOF
}

resource "aws_eip" "this" {
  #checkov:skip=CKV2_AWS_19:Attachment is done using the aws_eip_association resource
}

resource "aws_eip_association" "this" {
  instance_id   = aws_instance.this.id
  allocation_id = aws_eip.this.id
}

data "aws_route53_zone" "this" {
  name = var.domain_name
}

resource "aws_route53_record" "this" {
  for_each = var.create_dns_record ? tomap({ "${var.name}" = "${var.name}" }) : {}
  zone_id  = data.aws_route53_zone.this.zone_id

  name    = format("%s.%s", var.name, var.domain_name)
  type    = "A"
  ttl     = "3600"
  records = [aws_eip.this.public_ip]
}
