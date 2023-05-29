variable "aws_region" {
  type        = string
  description = "AWS region to create resources. Default Milan"
  default     = "eu-central-1"
}

variable "app_name" {
  type        = string
  default     = "website"
  description = "Corporate website."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment"
}

variable "env_short" {
  type        = string
  default     = "d"
  description = "Evnironment short."
}

################
## Networking ##
###############
variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPC cidr."
}

variable "vpc_private_subnets_cidr" {
  type        = list(string)
  description = "Private subnets list of cidr."
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "vpc_public_subnets_cidr" {
  type        = list(string)
  description = "Private subnets list of cidr."
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "vpc_database_subnets_cidr" {
  type        = list(string)
  description = "Internal subnets list of cidr. Mainly for private endpoints"
  default     = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable/Create nat gateway"
  default     = true
}

variable "single_nat_gateway" {
  type        = bool
  description = "Single natgateway instance."
  default     = true
}

## Public Dns zones
variable "public_dns_zones" {
  type        = map(any)
  description = "Route53 Hosted Zone"
  default     = null
}

variable "dns_record_ttl" {
  type        = number
  description = "Dns record ttl (in sec)"
  default     = 86400 # 24 hours
}

variable "enable_cdn_https" {
  type        = bool
  description = "Enable ApiGw https support: the TLS certificate must be issued and verified."
  default     = true
}

variable "cdn_custom_headers" {
  type = list(object(
    {
      header   = string
      override = bool
      value    = string
    }
  ))
  default = []
}


###############
## Computing ##
##############

variable "auto_deployments_enabled" {
  type        = bool
  description = "App runner auto deploy enabled."
  default     = false
}

variable "logs_lambda_retention" {
  type        = number
  description = "Days to retain the log stream."
  default     = 7
}

variable "log_apprunner_retention" {
  type        = number
  description = "Retention days policy related to a log group app runner"
  default     = 7
}

variable "cms_github_repository" {
  type        = string
  description = "github repository with CMS codebase in the form organisation/repository."
  default     = "pagopa/cms-corporate-backend"
}

variable "fe_github_repository" {
  type        = string
  description = "Fe repository"
  default     = "pagopa/corporate-site-fe"
}

variable "cms_public_ecr_image" {
  type        = string
  description = "Image name: set this name when you don't have your custom image in ECR yet"
  default     = null
}

variable "cms_image_version" {
  type        = string
  description = "Tag image version to deploy"
  default     = "latest"
}

variable "ecr_keep_nr_images" {
  type        = number
  description = "Number of images to keep in ECR repository."
  default     = 3
}

##############
## Database ##
#############

variable "db_backup_retention_period" {
  type        = number
  description = "The days to retain backups for. Default 7"
  default     = 7
}

variable "db_preferred_backup_window" {
  type        = string
  description = "The daily time range during which automated backups are created."
  default     = "17:00-19:00"
}

variable "db_stop_enable" {
  type        = bool
  description = "Enable rds aurora shutdown."
  default     = false
}

variable "db_start_schedule_expression" {
  type        = string
  description = "When the rds db aurora should start."
  default     = "cron(0 8 ? * MON-FRI *)" # UTC
}

variable "db_stop_schedule_expression" {
  type        = string
  description = "When the rds db aurora should start."
  default     = "cron(0 19 ? * MON-FRI *)" # UTC
}



variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}