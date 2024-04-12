resource "aws_cognito_user_pool_client" "web_app" {
  name = aws_cognito_user_pool.users.name

  user_pool_id = aws_cognito_user_pool.users.id
  supported_identity_providers = [
    "COGNITO",
    aws_cognito_identity_provider.facebook.provider_name,
    aws_cognito_identity_provider.google.provider_name,
    aws_cognito_identity_provider.apple.provider_name,
  ]

  callback_urls = var.callback_urls
  logout_urls   = var.callback_urls

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  read_attributes                      = ["email", "custom:ennaUserId", "custom:provider"]
  write_attributes                     = ["email", "custom:ennaUserId", "custom:provider"]
}
