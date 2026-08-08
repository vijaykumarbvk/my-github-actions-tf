# ---------------------------
# variables.tf
# ---------------------------
variable "github_org" {
  description = "GitHub username or org"
  type        = string
  default     = "vijaykumarbvk"
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
  default     = "my-github-actions-tf"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}