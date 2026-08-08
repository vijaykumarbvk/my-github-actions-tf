# ---------------------------
# iam.tf — IAM Role + Trust Policy
# ---------------------------
data "aws_iam_policy_document" "github_oidc_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_org}/${var.github_repo}:*"]
    }
  }
}

resource "aws_iam_role" "oidc_role" {
  name               = "oidc-role"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_trust.json
}

# ---------------------------
# Attach permissions — adjust to least privilege for your use case
# ---------------------------
resource "aws_iam_role_policy_attachment" "oidc_role_admin" {
  role       = aws_iam_role.oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}