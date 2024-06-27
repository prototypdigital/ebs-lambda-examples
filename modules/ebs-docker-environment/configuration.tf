resource "aws_s3_bucket" "api" {
  bucket = local.resource_name

  tags = {
    Name        = local.resource_name
    Environment = var.environment
  }
}

resource "aws_s3_object" "api_v1" {
  bucket      = aws_s3_bucket.api.id
  key         = "beanstalk/${var.environment}.zip"
  source      = data.archive_file.config.output_path
  source_hash = data.archive_file.config.output_base64sha256
}
