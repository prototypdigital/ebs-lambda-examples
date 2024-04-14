resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "CloudFront OAI for ${var.environment}"
}

resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Workshop web app: ${title(var.environment)}"
  price_class         = "PriceClass_100"
  aliases             = [var.s3_bucket_domain_name]
  default_root_object = "index.html"

  tags = {
    Name        = aws_s3_bucket.this.bucket_domain_name
    Environment = var.environment
  }

  origin {
    domain_name = aws_s3_bucket.this.bucket_domain_name
    origin_id   = aws_s3_bucket.this.id

    origin_shield {
      enabled              = true
      origin_shield_region = data.aws_region.current.name
    }

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.this.id
    compress         = true

    # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-origin-request-policies.html
    cache_policy_id          = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    origin_request_policy_id = "acba4595-bd28-49b8-b9fe-13317c0390fa"
    viewer_protocol_policy   = "redirect-to-https"

    dynamic "lambda_function_association" {
      for_each = var.viewer_request_function_arn == "" ? [] : [0]

      content {
        event_type   = "viewer-request"
        lambda_arn   = var.viewer_request_function_arn
        include_body = false
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = ["CN", "RU", "TR", "KP", "BR", "BD", "PK", "IR", "AF"]
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }
}

resource "aws_iam_user_policy" "invalidation" {
  name = "${aws_cloudfront_distribution.this.id}-invalidation-policy"
  user = aws_iam_user.this.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" = "Allow",
        "Action" = [
          "cloudfront:CreateInvalidation",
        ],
        "Resource" = "${aws_cloudfront_distribution.this.arn}"
      }
    ]
  })
}
