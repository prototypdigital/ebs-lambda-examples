resource "aws_s3_bucket" "this" {
  bucket = var.s3_bucket_domain_name

  tags = {
    Name        = var.s3_bucket_domain_name
    Environment = var.environment
  }
}

resource "aws_iam_user" "this" {
  name = "${aws_s3_bucket.this.id}-user"

}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

resource "aws_iam_user_policy" "objects" {
  name = "${aws_s3_bucket.this.id}-object-policy"
  user = aws_iam_user.this.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" = "Allow",
        "Action" = [
          "s3:GetBucketLocation",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:GetObject",
          "s3:GetObjectAcl",
          "s3:GetObjectVersion",
          "s3:DeleteObject",
          "s3:DeleteObjectVersion"
        ],
        "Resource" = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}

resource "aws_iam_user_policy" "list_all_buckets" {
  name = "${aws_s3_bucket.this.id}-list-buckets-policy"
  user = aws_iam_user.this.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" = "Allow",
        "Action" = [
          "s3:ListAllMyBuckets",
        ],
        "Resource" = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy" "list_bucket" {
  name = "${aws_s3_bucket.this.id}-list-bucket-policy"
  user = aws_iam_user.this.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" = "Allow",
        "Action" = [
          "s3:GetBucketLocation",
          "s3:ListBucket",
        ],
        "Resource" = "${aws_s3_bucket.this.arn}"
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.bucket.json
}

