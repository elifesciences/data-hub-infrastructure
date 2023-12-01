locals {
  project_name = "data-hub"
  sciety_events_bucket_name = "sciety-data-extractions"

  tags = {
    Project     = local.project_name
  }
}

resource "aws_iam_policy" "sciety_events_read_only" {
  name        = "${local.project_name}-sciety_events_read_only_access"
  path        = "/"
  description = "${local.project_name} read-only access to ${local.sciety_events_bucket_name} S3 Bucket"

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


resource "aws_iam_group_policy_attachment" "read-write-role-policy-attachment" {
  group      = var.data_hub_user_group_name
  policy_arn = aws_iam_policy.sciety_events_read_only.arn
}
