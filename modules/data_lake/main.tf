locals {
  bucket_names = {
    raw      = "${var.project_name}-${var.environment}-raw"
    processed = "${var.project_name}-${var.environment}-processed"
    curated  = "${var.project_name}-${var.environment}-curated"
  }
}

# Raw data bucket
resource "aws_s3_bucket" "raw" {
  bucket = local.bucket_names.raw

  tags = {
    Name        = local.bucket_names.raw
    DataZone    = "raw"
  }
}

# Processed data bucket
resource "aws_s3_bucket" "processed" {
  bucket = local.bucket_names.processed

  tags = {
    Name        = local.bucket_names.processed
    DataZone    = "processed"
  }
}

# Curated data bucket
resource "aws_s3_bucket" "curated" {
  bucket = local.bucket_names.curated

  tags = {
    Name        = local.bucket_names.curated
    DataZone    = "curated"
  }
}

# Enable versioning for all buckets
resource "aws_s3_bucket_versioning" "raw" {
  bucket = aws_s3_bucket.raw.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "processed" {
  bucket = aws_s3_bucket.processed.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "curated" {
  bucket = aws_s3_bucket.curated.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable encryption for all buckets
resource "aws_s3_bucket_server_side_encryption_configuration" "raw" {
  bucket = aws_s3_bucket.raw.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "processed" {
  bucket = aws_s3_bucket.processed.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "curated" {
  bucket = aws_s3_bucket.curated.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
} 