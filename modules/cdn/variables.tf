variable "s3_bucket_domain_name" {
  description = "Bucket domain name"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ACM Certificate for CloudFront distribution domain name."
  type        = string
}

variable "viewer_request_function_arn" {
  description = "Connects distribution to a HTTP Basic Auth Lambda function."
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment."
  type        = string

  validation {
    condition     = contains(["development", "production"], var.environment)
    error_message = "Allowed values for environment are development or production."
  }
}
