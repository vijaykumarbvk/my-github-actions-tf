# ---------------------------
# outputs.tf
# ---------------------------
output "oidc_role_arn" {
  value = aws_iam_role.oidc_role.arn
}

output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.github.arn
}