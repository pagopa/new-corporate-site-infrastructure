env_short   = "d"
environment = "dev"

# ecs_cms_image_version = "todo"

public_dns_zones = {
  "dev.pagopa.it" = {
    comment = "Corporate website dev."
  }
}

enable_cdn_https = true

cms_image_version        = "a1e4df3717f854eacfe56cdc4df3079a29b88f6a"
auto_deployments_enabled = true


# Ref: https://pagopa.atlassian.net/wiki/spaces/DEVOPS/pages/132810155/Azure+-+Naming+Tagging+Convention#Tagging
tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "PagoPa corporate website."
  Source      = "https://github.com/pagopa/new-corporate-site-infrastructure.git"
  CostCenter  = "TS310 - PAGAMENTI e SERVIZI"
}
