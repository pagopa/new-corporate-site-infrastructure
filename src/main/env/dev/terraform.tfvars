env_short   = "d"
environment = "dev"

# ecs_cms_image_version = "todo"

public_dns_zones = {
  "dev.pagopa.it" = {
    comment = "Corporate website dev."
  }
}

enable_cdn_https = true

cms_image_version        = "658b0b289970b74ca59d5d19cc2523811fa3a851"
auto_deployments_enabled = true


# Ref: https://pagopa.atlassian.net/wiki/spaces/DEVOPS/pages/132810155/Azure+-+Naming+Tagging+Convention#Tagging
tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "PagoPa corporate website."
  Source      = "https://github.com/pagopa/new-corporate-site-infrastructure.git"
  CostCenter  = "TS310 - PAGAMENTI e SERVIZI"
}
