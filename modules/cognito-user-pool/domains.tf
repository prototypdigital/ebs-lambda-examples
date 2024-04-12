resource "aws_cognito_user_pool_domain" "auth" {
  domain          = var.auth_domain_name
  certificate_arn = var.auth_certificate_arn
  user_pool_id    = aws_cognito_user_pool.users.id
}

resource "aws_cognito_user_pool_domain" "default" {
  domain       = aws_cognito_user_pool.users.name
  user_pool_id = aws_cognito_user_pool.users.id
}
