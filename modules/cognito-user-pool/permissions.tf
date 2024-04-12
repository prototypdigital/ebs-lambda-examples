resource "aws_lambda_permission" "custom_mailer" {
  statement_id  = "AllowCustomMailerExecutionFromCognito"
  action        = "lambda:InvokeFunction"
  principal     = "cognito-idp.amazonaws.com"
  function_name = module.cognito_custom_mailer.function_name
  source_arn    = aws_cognito_user_pool.users.arn
}

resource "aws_lambda_permission" "post_authentication" {
  statement_id  = "AllowPostAuthenticationExecutionFromCognito"
  action        = "lambda:InvokeFunction"
  principal     = "cognito-idp.amazonaws.com"
  function_name = module.cognito_post_authentication.function_name
  source_arn    = aws_cognito_user_pool.users.arn
}

resource "aws_lambda_permission" "create_auth_challenge" {
  statement_id  = "AllowCreationOfAuthChallengeFromCognito"
  action        = "lambda:InvokeFunction"
  principal     = "cognito-idp.amazonaws.com"
  function_name = module.cognito_create_auth_challenge.function_name
  source_arn    = aws_cognito_user_pool.users.arn
}

resource "aws_lambda_permission" "define_auth_challenge" {
  statement_id  = "AllowDefinitionOfAuthChallengeFromCognito"
  action        = "lambda:InvokeFunction"
  principal     = "cognito-idp.amazonaws.com"
  function_name = module.cognito_define_auth_challenge.function_name
  source_arn    = aws_cognito_user_pool.users.arn
}

resource "aws_lambda_permission" "verify_auth_challenge" {
  statement_id  = "AllowVerificationOfAuthChallengeFromCognito"
  action        = "lambda:InvokeFunction"
  principal     = "cognito-idp.amazonaws.com"
  function_name = module.cognito_verify_auth_challenge.function_name
  source_arn    = aws_cognito_user_pool.users.arn
}


resource "aws_lambda_permission" "pre_signup" {
  statement_id  = "AllowPreSignupExecutionFromCognito"
  action        = "lambda:InvokeFunction"
  principal     = "cognito-idp.amazonaws.com"
  function_name = module.cognito_pre_signup.function_name
  source_arn    = aws_cognito_user_pool.users.arn
}
