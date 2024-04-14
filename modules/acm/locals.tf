locals {
  validation_options_map = { for item in aws_acm_certificate.this.domain_validation_options : item.resource_record_name => item }
}
