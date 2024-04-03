terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 0.14.0"
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_access_secret
}

# Create IAM user
resource "aws_iam_user" "this" {
  name = "terraform"
}

# Create IAM access key
resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

# Create IAM user login profile
resource "aws_iam_user_login_profile" "this" {
  user = aws_iam_user.this.name

  #   Fix for issue with password reset by user recreating user: https://github.com/hashicorp/terraform-provider-aws/issues/23567
  password_reset_required = true
  lifecycle {
    ignore_changes = [password_reset_required]
  }
}


# Superadmin policy
resource "aws_iam_policy" "superadmin" {
  name        = "AWSFullAccess"
  description = "Allows the user to manage all resources on this AWS account"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      },
    ]
  })
}

# Create owners group
resource "aws_iam_group" "this" {
  name = "owners"
}

# Attach superadmin policy to owners group
resource "aws_iam_group_policy_attachment" "this" {
  group      = aws_iam_group.this.name
  policy_arn = aws_iam_policy.superadmin.arn
}

# Add user to owners group
resource "aws_iam_group_membership" "this" {
  name  = aws_iam_group.this.name
  group = aws_iam_group.this.name
  users = [aws_iam_user.this.name]
}

data "aws_caller_identity" "current" {}
