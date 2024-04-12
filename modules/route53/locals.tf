locals {
  environment        = "development"
  client_domain_name = "dev.opskrba.hr"
  api_domain_name    = "api.${local.client_domain_name}"
  auth_domain_name   = "auth.${local.client_domain_name}"
}
