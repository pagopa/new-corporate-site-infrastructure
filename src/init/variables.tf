variable "aws_region" {
  type        = string
  description = "AWS region."
  default     = "eu-central-1"
}

variable "environment" {
  type        = string
  description = "Environment. Possible values are: Dev, Uat, Prod"
  default     = "Dev"
}

variable "github_repository" {
  type        = string
  description = "This github repository"
  default     = "pagopa/new-corporate-site-infrastructure"
}


variable "tags" {
  type = map(any)
  default = {
    "CreatedBy" : "Terraform",
    "Environment" : "Dev"
  }
}