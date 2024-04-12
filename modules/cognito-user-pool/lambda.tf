module "cognito_custom_mailer" {
  source          = "../lambda/cognito/custom-mailer"
  environment     = var.environment
  lambda_role_arn = var.lambda_role_arn

  env_vars = {
    SMTP_HOST     = "smtp.office365.com"
    SMTP_FROM     = var.smtp_username
    SMTP_USER     = var.smtp_username
    SMTP_PASSWORD = var.smtp_password
    DOMAIN_NAME   = var.callback_urls[0]
    KMS_KEY_ARN   = aws_kms_key.cognito.arn
    KMS_KEY_ALIAS = "${var.user_pool_name}-users"
  }
}

module "cognito_post_authentication" {
  source          = "../lambda/cognito/post-authentication"
  environment     = var.environment
  lambda_role_arn = var.lambda_role_arn
  api_url         = var.api_url
}

module "cognito_pre_authentication" {
  source          = "../lambda/cognito/pre-authentication"
  environment     = var.environment
  lambda_role_arn = var.lambda_role_arn
  api_url         = var.api_url
}

module "cognito_pre_signup" {
  source          = "../lambda/cognito/pre-signup"
  environment     = var.environment
  lambda_role_arn = var.lambda_role_arn
  api_url         = var.api_url
}

module "cognito_define_auth_challenge" {
  source          = "../lambda/cognito/define-auth-challenge"
  environment     = var.environment
  lambda_role_arn = var.lambda_role_arn
  api_url         = var.api_url
}

module "cognito_create_auth_challenge" {
  source          = "../lambda/cognito/create-auth-challenge"
  environment     = var.environment
  lambda_role_arn = var.lambda_role_arn
  api_url         = var.api_url
}

module "cognito_verify_auth_challenge" {
  source          = "../lambda/cognito/verify-auth-challenge"
  environment     = var.environment
  lambda_role_arn = var.lambda_role_arn
  api_url         = var.api_url
}
