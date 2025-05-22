output "bucket_names" {
  description = "Names of the created S3 buckets"
  value = {
    raw       = aws_s3_bucket.raw.id
    processed = aws_s3_bucket.processed.id
    curated   = aws_s3_bucket.curated.id
  }
}

output "bucket_arns" {
  description = "ARNs of the created S3 buckets"
  value = {
    raw       = aws_s3_bucket.raw.arn
    processed = aws_s3_bucket.processed.arn
    curated   = aws_s3_bucket.curated.arn
  }
} 