<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.46.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_dns_record"></a> [create\_dns\_record](#input\_create\_dns\_record) | Toggle to create A record | `bool` | `true` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `string` | `null` | no |
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | n/a | `map` | `{}` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | n/a | `map` | `{}` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type | `string` | `"t3.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Name of SSH key | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `null` | no |
| <a name="input_ubuntu_version"></a> [ubuntu\_version](#input\_ubuntu\_version) | Ubuntu version | `string` | `"22.04"` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | EBS volume size | `number` | `8` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | FQDN of associated DNS records |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | EC2 instance ID |
| <a name="output_instance_public_ip"></a> [instance\_public\_ip](#output\_instance\_public\_ip) | Public IP assigned to EC2 instance |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Public Elastic IP |
<!-- END_TF_DOCS -->