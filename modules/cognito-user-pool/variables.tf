variable "user_pool_name" {
  description = "User pool name."
  type        = string
}

variable "auth_domain_name" {
  description = "User pool auth domain name."
  type        = string
}

variable "api_url" {
  description = "API domain name for functions."
  type        = string
}

variable "auth_certificate_arn" {
  description = "User pool auth certificate ARN."
  type        = string
}

variable "google_client_id" {
  description = "Google Identity Provider client id."
  type        = string
  sensitive   = true
}

variable "google_client_secret" {
  description = "Google Identity Provider client secret."
  type        = string
  sensitive   = true
}

variable "facebook_client_id" {
  description = "Facebook Identity Provider client id."
  type        = string
  sensitive   = true
}

variable "facebook_client_secret" {
  description = "Facebook Identity Provider client secret."
  type        = string
  sensitive   = true
}

variable "apple_services_id" {
  description = "Apple Identity Provider Services ID"
  sensitive   = true
}

variable "apple_team_id" {
  description = "Apple Identity Provider Team ID"
  sensitive   = true
}

variable "apple_key_id" {
  description = "Apple Identity Provider Key ID"
  sensitive   = true
}

variable "apple_key" {
  description = "Apple Identity Provider Key"
  sensitive   = true
}

variable "microsoft_client_id" {
  type        = string
  description = "Microsoft Client ID"
  sensitive   = true
}

variable "microsoft_tennant_id" {
  type        = string
  description = "Microsoft Tennant ID"
  sensitive   = true
}

variable "callback_urls" {
  description = "Client domain name."
  type        = list(string)
}

variable "lambda_role_arn" {
  description = "Lambda role ARN."
  type        = string
}

variable "smtp_username" {
  sensitive   = true
  type        = string
  description = "Username for the SMTP server"
}

variable "smtp_password" {
  sensitive   = true
  type        = string
  description = "Password for the SMTP server"
}

variable "environment" {
  description = "Environment."
  type        = string

  validation {
    condition     = contains(["development", "production"], var.environment)
    error_message = "Allowed values for environment are development or production."
  }
}
