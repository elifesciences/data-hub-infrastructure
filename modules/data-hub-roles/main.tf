locals {
  project_name = "data-hub"

  tags = {
    Project     = local.project_name
    Environment = var.env
  }
}

resource "aws_iam_role" "data_hub_worker_role" {
  name = "${local.project_name}-${var.env}-data-hub-worker"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action : "sts:AssumeRoleWithWebIdentity",
        Effect : "Allow",
        Principal : {
          Federated : "arn:aws:iam::${var.account_id}:oidc-provider/${var.irsa_oidc_provider}"
        },
        Condition : {
          StringEquals : {
            "${var.irsa_oidc_provider}:sub" : "system:serviceaccount:${var.data_hub_worker_irsa_namespace}:${var.data_hub_worker_irsa_service_account}"
          }
        }
      },
    ]
  })

  tags = local.tags
}
