module "ssl_certificates" {
  source      = "./ssl"
  domain_name = "cobe.larva.cloud"
  environment = local.environment

  providers = {
    aws = aws.global
  }
}

module "storage" {
  source = "../../modules/cdn"

  environment = local.environment
  s3_bucket_domain_name = "cdn.${module.ssl_certificates.frontend.domain_name}"
  acm_certificate_arn =  module.ssl_certificates.frontend.arn
}