resource "aws_route53_zone" "this" {
  name = var.domain_name
}

resource "aws_route53_record" "web" {
  zone_id = aws_route53_zone.this.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.web_app_alias
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = true
  }
}

