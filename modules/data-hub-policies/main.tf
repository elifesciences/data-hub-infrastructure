locals {
  project_name = "data-hub"

  tags = {
    Project     = local.project_name
  }
}

resource "aws_iam_policy" "list_all_buckets" {
  name        = "${local.project_name}-list-all-buckets"
  path        = "/"
  description = "${local.project_name} permission to list all buckets"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetBucketLocation",
          "s3:ListAllMyBuckets"
        ],
        "Resource": "*"
      }
    ]
  })

  tags = local.tags
}


resource "aws_iam_policy" "full_access_buckets" {
  name        = "${local.project_name}-full-access-buckets"
  path        = "/"
  description = "${local.project_name} full access access to S3 buckets"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:*"
        ],
        "Resource": [
          "arn:aws:s3:::prod-elife-task-adept",
          "arn:aws:s3:::prod-elife-task-adept/*",
          "arn:aws:s3:::prod-elife-submissions-ejp",
          "arn:aws:s3:::prod-elife-submissions-ejp/*"
        ]
      }
    ]
  })

  tags = local.tags
}

resource "aws_iam_policy" "read_write_access_buckets" {
  name        = "${local.project_name}-read-write-buckets"
  path        = "/"
  description = "${local.project_name} read-write access to S3 buckets"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:AbortMultipartUpload",
          "s3:DeleteObject*",
          "s3:Get*",
          "s3:List*",
          "s3:Put*"
        ],
        "Resource": [
          "arn:aws:s3:::prod-elife-kriya",
          "arn:aws:s3:::prod-elife-kriya/*",
          "arn:aws:s3:::ci-elife-data-pipeline",
          "arn:aws:s3:::ci-elife-data-pipeline/*",
          "arn:aws:s3:::prod-elife-data-pipeline",
          "arn:aws:s3:::prod-elife-data-pipeline/*",
          "arn:aws:s3:::staging-elife-data-pipeline",
          "arn:aws:s3:::staging-elife-data-pipeline/*",
          "arn:aws:s3:::flux-elife-data-pipeline",
          "arn:aws:s3:::flux-elife-data-pipeline/*",
          "arn:aws:s3:::elife-ejp-review-data",
          "arn:aws:s3:::elife-ejp-review-data/*"
        ]
      }
    ]
  })

  tags = local.tags
}

resource "aws_iam_policy" "read_only_access_buckets" {
  name        = "${local.project_name}-read-only-buckets"
  path        = "/"
  description = "${local.project_name} read-only access to S3 buckets"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:Get*",
          "s3:List*",
        ],
        "Resource": [
          "arn:aws:s3:::elife-ejp-ftp-db-xml-dump",
          "arn:aws:s3:::elife-ejp-ftp-db-xml-dump/*",
          "arn:aws:s3:::elife-ejp-ftp-db-xml-dump--test",
          "arn:aws:s3:::elife-ejp-ftp-db-xml-dump--test/*",
          "arn:aws:s3:::elife-ejp-ftp",
          "arn:aws:s3:::elife-ejp-ftp/*",
          "arn:aws:s3:::elife-ejp-ftp--test",
          "arn:aws:s3:::elife-ejp-ftp--test/*",
          "arn:aws:s3:::biorxiv-src-monthly/*",
          "arn:aws:s3:::biorxiv-src-monthly",
          "arn:aws:s3:::sciety-data-extractions",
          "arn:aws:s3:::sciety-data-extractions/*"
        ]
      }
    ]
  })

  tags = local.tags
}
