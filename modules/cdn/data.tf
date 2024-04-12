data "aws_region" "current" {}

data "aws_iam_policy_document" "bucket" {
  statement {
    sid = "ListBucket"

    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.this.arn]
    }

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [
      aws_s3_bucket.this.arn,
    ]
  }

  statement {
    sid = "ManageBucketObjects"

    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.this.arn]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:DeleteObject"
    ]

    resources = [
      "${aws_s3_bucket.this.arn}/*",
    ]
  }

  statement {
    sid = "CloudFrontOriginAccessIdentityRead"

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.this.iam_arn]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.this.arn}/*",
    ]
  }
}
