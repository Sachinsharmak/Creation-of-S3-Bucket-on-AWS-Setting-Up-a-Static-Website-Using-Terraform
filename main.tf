# Create a S3 bucket -auto-approve
resource "aws_s3_bucket" "project1-bucket1" {
  bucket = var.bucket_name

}
# Ownership of Bucket
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.project1-bucket1.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
# Make it public
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.project1-bucket1.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.project1-bucket1.id
  acl    = "public-read"
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.project1-bucket1.id
  key = "index.html"
  source = "index.html"
  acl = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.project1-bucket1.id
  key = "error.html"
  source = "error.html"
  acl = "public-read"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "website-1" {
  bucket = aws_s3_bucket.project1-bucket1.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
  depends_on = [ aws_s3_bucket.project1-bucket1 ]


}