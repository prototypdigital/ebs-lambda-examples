resource "aws_cognito_identity_provider" "google" {
  user_pool_id  = aws_cognito_user_pool.users.id
  provider_name = "Google"
  provider_type = "Google"

  provider_details = {
    client_id     = var.google_client_id
    client_secret = var.google_client_secret

    attributes_url                = "https://people.googleapis.com/v1/people/me?personFields="
    attributes_url_add_attributes = "true"

    authorize_scopes = "email profile openid"
    authorize_url    = "https://accounts.google.com/o/oauth2/v2/auth"

    oidc_issuer          = "https://accounts.google.com"
    token_request_method = "POST"
    token_url            = "https://www.googleapis.com/oauth2/v4/token"
  }

  attribute_mapping = {
    email    = "email"
    username = "sub"
    name     = "name"
  }
}

resource "aws_cognito_identity_provider" "facebook" {
  user_pool_id  = aws_cognito_user_pool.users.id
  provider_name = "Facebook"
  provider_type = "Facebook"

  provider_details = {
    client_id     = var.facebook_client_id
    client_secret = var.facebook_client_secret

    attributes_url                = "https://graph.facebook.com/v15.0/me?fields="
    attributes_url_add_attributes = "true"

    authorize_scopes = "public_profile, email",
    authorize_url    = "https://www.facebook.com/v15.0/dialog/oauth"

    token_request_method = "GET"
    token_url            = "https://graph.facebook.com/v15.0/oauth/access_token"
  }

  attribute_mapping = {
    email    = "email"
    username = "id"
    name     = "name"
  }
}

resource "aws_cognito_identity_provider" "apple" {
  user_pool_id  = aws_cognito_user_pool.users.id
  provider_name = "SignInWithApple"
  provider_type = "SignInWithApple"

  provider_details = {
    client_id   = var.apple_services_id
    team_id     = var.apple_team_id
    key_id      = var.apple_key_id
    private_key = var.apple_key

    attributes_url_add_attributes = "false"

    authorize_scopes = "email name",
    authorize_url    = "https://appleid.apple.com/auth/authorize"

    oidc_issuer          = "https://appleid.apple.com"
    token_request_method = "POST"
    token_url            = "https://appleid.apple.com/auth/token"
  }

  attribute_mapping = {
    email    = "email"
    name     = "name"
    username = "sub"
  }

  lifecycle {
    ignore_changes = [provider_details]
  }
}

