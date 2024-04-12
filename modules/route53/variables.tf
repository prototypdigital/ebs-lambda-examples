variable "domain_name" {
  type        = string
  description = "The domain name for the zone."
}

variable "web_app_alias" {
  type        = string
  description = "The domain name for the web app."
}

variable "auth_domain_alias" {
  type        = string
  description = "Cognito domain name alias."
}

variable "cloudfront_zone_id" {
  type        = string
  description = "The route53 zone id for the web app."
}
