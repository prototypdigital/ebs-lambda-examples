resource "aws_acm_certificate" "this" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  subject_alternative_names = var.additional_domain_names

  tags = {
    Name        = var.domain_name
    Environment = var.environment
  }
}

resource "aws_route53_zone" "this" {
  name = var.domain_name
}

resource "aws_route53_record" "this" {
  for_each = local.validation_options_map
  zone_id  = aws_route53_zone.this.zone_id
  name     = each.value.resource_record_name
  type     = each.value.resource_record_type
  records  = [each.value.resource_record_value]
  ttl      = "300"
}
