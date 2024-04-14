output "app_domain_validation_options" {
  description = "SSL Domain Validation Options"
  value       = module.ssl_certificates.api.domain_validation_options
}

output "api_domain_validation_options" {
  description = "SSL Domain Validation Options"
  value       = module.ssl_certificates.frontend.domain_validation_options
}
