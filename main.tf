# Terraform configuration for Bateman Tree Goods static website hosting on S3

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
    Name        = "Bateman Tree Goods Website"
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

# Upload logo.png
resource "aws_s3_object" "logo" {
  bucket       = aws_s3_bucket.website.id
  key          = "logo.png"
  source       = "${path.module}/logo.png"
  content_type = "image/png"
  etag         = filemd5("${path.module}/logo.png")
}

# Upload favicon.ico
resource "aws_s3_object" "favicon_ico" {
  bucket       = aws_s3_bucket.website.id
  key          = "favicon.ico"
  source       = "${path.module}/favicon.ico"
  content_type = "image/x-icon"
  etag         = filemd5("${path.module}/favicon.ico")
}

# Upload favicon-32x32.png
resource "aws_s3_object" "favicon_32" {
  bucket       = aws_s3_bucket.website.id
  key          = "favicon-32x32.png"
  source       = "${path.module}/favicon-32x32.png"
  content_type = "image/png"
  etag         = filemd5("${path.module}/favicon-32x32.png")
}

# Upload favicon-16x16.png
resource "aws_s3_object" "favicon_16" {
  bucket       = aws_s3_bucket.website.id
  key          = "favicon-16x16.png"
  source       = "${path.module}/favicon-16x16.png"
  content_type = "image/png"
  etag         = filemd5("${path.module}/favicon-16x16.png")
}

# Upload apple-touch-icon.png
resource "aws_s3_object" "apple_touch_icon" {
  bucket       = aws_s3_bucket.website.id
  key          = "apple-touch-icon.png"
  source       = "${path.module}/apple-touch-icon.png"
  content_type = "image/png"
  etag         = filemd5("${path.module}/apple-touch-icon.png")
}
