# EMR IAM roles
resource "aws_iam_role" "emr_service_role" {
  name = "${var.project_name}-${var.environment}-emr-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "elasticmapreduce.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "emr_service_role" {
  role       = aws_iam_role.emr_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceRole"
}

resource "aws_iam_role" "emr_ec2_role" {
  name = "${var.project_name}-${var.environment}-emr-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "emr_ec2_role" {
  role       = aws_iam_role.emr_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceforEC2Role"
}

resource "aws_iam_instance_profile" "emr_ec2_profile" {
  name = "${var.project_name}-${var.environment}-emr-ec2-profile"
  role = aws_iam_role.emr_ec2_role.name
}

# EMR security group
resource "aws_security_group" "emr_master" {
  name        = "${var.project_name}-${var.environment}-emr-master"
  description = "Security group for EMR master node"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
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

# EMR Cluster
resource "aws_emr_cluster" "cluster" {
  name          = var.cluster_name
  release_label = var.release_label
  service_role  = aws_iam_role.emr_service_role.arn

  applications = ["Spark", "Hive", "Hadoop"]

  termination_protection = false
  keep_job_flow_alive_when_no_steps = true

  ec2_attributes {
    subnet_id                         = var.subnet_ids[0]
    emr_managed_master_security_group = aws_security_group.emr_master.id
    instance_profile                  = aws_iam_instance_profile.emr_ec2_profile.arn
  }

  master_instance_group {
    instance_type = var.instance_type
  }

  core_instance_group {
    instance_type  = var.instance_type
    instance_count = 2
  }

  tags = {
    Name        = var.cluster_name
    Environment = var.environment
  }

  configurations_json = jsonencode([
    {
      Classification = "spark-defaults"
      Properties = {
        "spark.dynamicAllocation.enabled" = "true"
        "spark.shuffle.service.enabled"   = "true"
      }
    }
  ])
} 