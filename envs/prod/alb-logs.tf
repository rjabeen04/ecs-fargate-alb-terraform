data "aws_caller_identity" "current" {}

# S3 bucket for ALB access logs (must be globally unique)
resource "aws_s3_bucket" "alb_logs" {
  bucket = "alb-logs-008996490878-prod"
}

resource "aws_s3_bucket_public_access_block" "alb_logs" {
  bucket                  = aws_s3_bucket.alb_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_policy" "alb_logs" {
  bucket = aws_s3_bucket.alb_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowELBLogDeliveryWrite"
        Effect    = "Allow"
        Principal = { Service = "logdelivery.elasticloadbalancing.amazonaws.com" }
        Action    = ["s3:PutObject"]
        Resource = [
          # No prefix case
          "${aws_s3_bucket.alb_logs.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
          # Prefix case (ALB writes: <prefix>/AWSLogs/...)
          "${aws_s3_bucket.alb_logs.arn}/*/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        ]
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      },
      {
        Sid       = "AllowELBLogDeliveryAclCheck"
        Effect    = "Allow"
        Principal = { Service = "logdelivery.elasticloadbalancing.amazonaws.com" }
        Action    = ["s3:GetBucketAcl", "s3:GetBucketLocation"]
        Resource  = aws_s3_bucket.alb_logs.arn
      }
    ]
  })
}


# Lifecycle rule to expire ALB access logs
resource "aws_s3_bucket_lifecycle_configuration" "alb_logs" {
  bucket = aws_s3_bucket.alb_logs.id

  rule {
    id     = "expire-alb-access-logs"
    status = "Enabled"

    filter {
      prefix = "ecs-fargate-alb-prod/AWSLogs/"
    }

    expiration {
      days = 7
    }
  }
}












