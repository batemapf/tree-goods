# Terraform configuration for Ordinary Tree Goods static website hosting on S3

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# S3 bucket for website hosting
resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name

  tags = {
    Name        = "Ordinary Tree Goods Website"
    Environment = var.environment
  }
}

# S3 bucket website configuration
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# S3 bucket public access block configuration
resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# S3 bucket policy for public read access
resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.website.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.website]
}

# Upload index.html
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.website.id
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/index.html")
}

# Upload styles.css
resource "aws_s3_object" "styles" {
  bucket       = aws_s3_bucket.website.id
  key          = "styles.css"
  source       = "${path.module}/styles.css"
  content_type = "text/css"
  etag         = filemd5("${path.module}/styles.css")
}

# Upload script.js
resource "aws_s3_object" "script" {
  bucket       = aws_s3_bucket.website.id
  key          = "script.js"
  source       = "${path.module}/script.js"
  content_type = "application/javascript"
  etag         = filemd5("${path.module}/script.js")
}

# Upload all assets
resource "aws_s3_object" "assets" {
  for_each = fileset("${path.module}/assets", "**/*")

  bucket = aws_s3_bucket.website.id
  key    = "assets/${each.value}"
  source = "${path.module}/assets/${each.value}"
  etag   = filemd5("${path.module}/assets/${each.value}")

  content_type = lookup({
    "png"  = "image/png"
    "ico"  = "image/x-icon"
    "jpg"  = "image/jpeg"
    "jpeg" = "image/jpeg"
    "svg"  = "image/svg+xml"
    "gif"  = "image/gif"
    "webp" = "image/webp"
  }, split(".", each.value)[length(split(".", each.value)) - 1], "application/octet-stream")
}
