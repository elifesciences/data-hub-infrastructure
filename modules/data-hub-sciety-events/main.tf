locals {
  project_name = "data-hub"
  sciety_events_bucket_name = "sciety-data-extractions"

  tags = {
    Project     = local.project_name
    Environment = var.env
  }
}

resource "aws_iam_policy" "sciety_events_read_only" {
  name        = "${local.project_name}-${var.env}-sciety_events_read_only_access"
  path        = "/"
  description = "${local.project_name} ${var.env} read-only access to ${local.sciety_events_bucket_name} S3 Bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid : "List",
        Effect : "Allow",
        Action : [
          "s3:ListBucket"
        ],
        Resource : [
          "arn:aws:s3:::${local.sciety_events_bucket_name}",
        ]
      },
      {
        Sid : "AccessSubPaths",
        Effect : "Allow",
        Action : [
          "s3:GetObject",
        ],
        Resource : [
          "arn:aws:s3:::${local.sciety_events_bucket_name}/*",
        ]
      }
    ]
  })

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "import-role-s3-read-write-policy-attachment" {
  role       = var.data_hub_worker_role_name
  policy_arn = aws_iam_policy.sciety_events_read_only.arn
}
