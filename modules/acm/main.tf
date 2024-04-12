resource "aws_acm_certificate" "this" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  subject_alternative_names = var.additional_domain_names

  tags = {
    Name        = var.domain_name
    Environment = var.environment
  }
}
