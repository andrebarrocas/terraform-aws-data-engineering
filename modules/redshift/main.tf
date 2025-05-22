# Redshift IAM role
resource "aws_iam_role" "redshift_role" {
  name = "${var.project_name}-${var.environment}-redshift-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "redshift.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "redshift_s3_read" {
  role       = aws_iam_role.redshift_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Redshift subnet group
resource "aws_redshift_subnet_group" "main" {
  name       = "${var.project_name}-${var.environment}-redshift-subnet"
  subnet_ids = var.subnet_ids

  tags = {
    Environment = var.environment
  }
}

# Redshift security group
resource "aws_security_group" "redshift" {
  name        = "${var.project_name}-${var.environment}-redshift"
  description = "Security group for Redshift cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Generate a random password for the Redshift master user
resource "random_password" "master_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Redshift cluster
resource "aws_redshift_cluster" "main" {
  cluster_identifier = var.cluster_identifier
  database_name     = var.database_name
  master_username   = var.master_username
  master_password   = random_password.master_password.result
  node_type        = var.node_type
  cluster_type     = var.number_of_nodes > 1 ? "multi-node" : "single-node"
  number_of_nodes  = var.number_of_nodes

  vpc_security_group_ids    = [aws_security_group.redshift.id]
  cluster_subnet_group_name = aws_redshift_subnet_group.main.name
  iam_roles                = [aws_iam_role.redshift_role.arn]

  skip_final_snapshot = true
  publicly_accessible = false

  encrypted = true

  tags = {
    Name        = var.cluster_identifier
    Environment = var.environment
  }
} 