# Create bucket for static content
resource "aws_s3_bucket" "magento_static_content" {
    bucket_prefix = "magento_static_content-"
}

# enable versioning
resource "aws_s3_bucket_versioning" "magento_static_content_versioning" {
  bucket = aws_s3_bucket.magento_static_content.id
  versioning_configuration {
    status = "Enabled"
  }
}