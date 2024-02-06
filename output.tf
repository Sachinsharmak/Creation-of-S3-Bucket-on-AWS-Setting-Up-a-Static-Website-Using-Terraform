output "bucket_output" {
  value = aws_s3_bucket.project1-bucket1.website_endpoint
}