output "domain_validation_options" {
  description = "A map of domain validation record key values"
  value       = aws_acm_certificate.this.domain_validation_options
}

output "domain_name" {
  description = "A map of domain validation record key values"
  value       = aws_acm_certificate.this.domain_name
}

output "arn" {
  description = "ARN of the ACM resource"
  value       = aws_acm_certificate.this.arn
}
