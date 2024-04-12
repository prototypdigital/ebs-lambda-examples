output "user_pool_id" {
  description = "ID of the Cognito User Pool."
  sensitive   = true
  value       = aws_cognito_user_pool_client.web_app.user_pool_id
}

output "client_id" {
  description = "ID of the Cognito User Pool Client."
  sensitive   = true
  value       = aws_cognito_user_pool_client.web_app.id
}

output "domain_name" {
  description = "Domain name of the Cognito User Pool."
  value       = aws_cognito_user_pool_domain.auth.domain
}
