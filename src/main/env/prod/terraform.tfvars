env_short   = "p"
environment = "prod"

public_dns_zones = {
  "pagopa.it" = {
    comment = "Corporate website prod."
  }
}

enable_cdn_https = true

#cms_public_ecr_image     = "public.ecr.aws/aws-containers/hello-app-runner"
cms_image_version        = "067a552ede38a74af2192d0ee350ff14e3567db1"
auto_deployments_enabled = true
log_apprunner_retention  = 30
ecr_keep_nr_images       = 5

## RDS
db_backup_retention_period = 20


# Ref: https://pagopa.atlassian.net/wiki/spaces/DEVOPS/pages/132810155/Azure+-+Naming+Tagging+Convention#Tagging
tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "PagoPa corporate website."
  Source      = "https://github.com/pagopa/new-corporate-site-infrastructure.git"
  CostCenter  = "TS310 - PAGAMENTI e SERVIZI"
}
