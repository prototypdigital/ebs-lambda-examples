module "ssl_app" {
  source = "../../../modules/acm"

  environment = var.environment
  domain_name = var.domain_name

  providers = {
    aws = aws
  }
}

module "ssl_api" {
  source = "../../../modules/acm"

  environment = var.environment
  domain_name = "api.${var.domain_name}"
}

