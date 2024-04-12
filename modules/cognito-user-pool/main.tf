resource "aws_cognito_user_pool" "users" {
  name                     = var.user_pool_name
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]
  deletion_protection      = "ACTIVE"

  tags = {
    env = var.environment
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  lambda_config {
    kms_key_id = aws_kms_key.cognito.arn
    custom_email_sender {
      lambda_arn     = module.cognito_custom_mailer.lambda_arn
      lambda_version = "V1_0"
    }

    pre_sign_up                    = module.cognito_pre_signup.lambda_arn
    define_auth_challenge          = module.cognito_define_auth_challenge.lambda_arn
    create_auth_challenge          = module.cognito_create_auth_challenge.lambda_arn
    verify_auth_challenge_response = module.cognito_verify_auth_challenge.lambda_arn
  }

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = false
    require_uppercase                = true
    temporary_password_validity_days = 7
  }

  schema {
    name                = "ennaUserId"
    attribute_data_type = "String"
    required            = false
    mutable             = true

    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
  }

  schema {
    name                = "provider"
    attribute_data_type = "String"
    required            = false
    mutable             = true

    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
  }
}
