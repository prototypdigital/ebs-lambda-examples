output "s3_bucket_domain_name" {
  value = aws_s3_bucket.this.bucket
}

output "bucket_id" {
  value = aws_s3_bucket.this.id
}

output "s3_regional_domain_name" {
  value = aws_s3_bucket.this.bucket_regional_domain_name
}

output "domain_name" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "cdn_zone_id" {
  value = aws_cloudfront_distribution.this.hosted_zone_id
}

output "s3_access_key" {
  value     = aws_iam_access_key.this.id
  sensitive = true
}

output "s3_access_secret" {
  value     = aws_iam_access_key.this.secret
  sensitive = true
}
