env_short   = "p"
environment = "prod"

public_dns_zones = {
  "pagopa.it" = {
    comment = "Corporate website prod."
  }
}

enable_cdn_https = false

cms_public_ecr_image     = "public.ecr.aws/aws-containers/hello-app-runner"
cms_image_version        = "latest"
auto_deployments_enabled = false


# Ref: https://pagopa.atlassian.net/wiki/spaces/DEVOPS/pages/132810155/Azure+-+Naming+Tagging+Convention#Tagging
tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "PagoPa corporate website."
  Source      = "https://github.com/pagopa/new-corporate-site-infrastructure.git"
  CostCenter  = "TS310 - PAGAMENTI e SERVIZI"
}
