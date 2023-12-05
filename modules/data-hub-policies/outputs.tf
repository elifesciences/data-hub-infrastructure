output "list_all_buckets_policy_name" {
  value = aws_iam_policy.list_all_buckets.name
}

output "full_access_buckets_policy_name" {
  value = aws_iam_policy.full_access_buckets.name
}

output "read_write_access_buckets_policy_name" {
  value = aws_iam_policy.read_write_access_buckets.name
}

output "read_only_access_buckets_policy_name" {
  value = aws_iam_policy.read_only_access_buckets.name
}
