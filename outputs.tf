output "user_name" {
  description = "AWS IAM User Name."
  value       = aws_iam_user.this.name
}

output "user_arn" {
  description = "AWS IAM User ID."
  value       = aws_iam_user.this.arn
}

output "user_access_key" {
  description = "AWS IAM User Access Key."
  value       = aws_iam_access_key.this.id
  sensitive   = true
}

output "user_access_secret" {
  description = "AWS IAM User Access Secret."
  value       = aws_iam_access_key.this.secret
  sensitive   = true
}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "initial_password" {
  value = aws_iam_user_login_profile.dashboard.password
}


