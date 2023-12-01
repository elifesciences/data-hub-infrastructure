output "worker_role_arn" {
  value = aws_iam_role.data_hub_worker_role.arn
}

output "worker_role_name" {
  value = aws_iam_role.data_hub_worker_role.name
}
