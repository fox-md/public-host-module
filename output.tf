output "public_ip" {
  value       = aws_eip.this.public_ip
  description = "Public Elastic IP"
}

output "instance_public_ip" {
  value       = aws_instance.this.public_ip
  description = "Public IP assigned to EC2 instance"
}

output "fqdn" {
  value       = var.create_dns_record ? aws_route53_record.this[var.name].fqdn : null
  description = "FQDN of associated DNS records"
}

output "instance_id" {
  value       = aws_instance.this.id
  description = "EC2 instance ID"
}
