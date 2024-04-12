output "frontend" {
  description = "SSL certificate for the frontend application"
  value       = module.ssl_app
}

output "api" {
  description = "SSL certificate for the API application"
  value       = module.ssl_api
}
