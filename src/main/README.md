## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.4.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 4.58.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | = 4.58.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs_cms_image_version"></a> [ecs\_cms\_image\_version](#input\_ecs\_cms\_image\_version) | Cms image to deploy | `string` | n/a | yes |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Corporate website. | `string` | `"website"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to create resources. Default Milan | `string` | `"eu-central-1"` | no |
| <a name="input_cms_github_repository"></a> [cms\_github\_repository](#input\_cms\_github\_repository) | github repository with CMS codebase in the form organisation/repository. | `string` | `"pagopa/cms-corporate-backend"` | no |
| <a name="input_create_cert_validation_records"></a> [create\_cert\_validation\_records](#input\_create\_cert\_validation\_records) | Create dns certification validation records. | `bool` | `true` | no |
| <a name="input_db_backup_retention_period"></a> [db\_backup\_retention\_period](#input\_db\_backup\_retention\_period) | The days to retain backups for. Default 7 | `number` | `7` | no |
| <a name="input_db_preferred_backup_window"></a> [db\_preferred\_backup\_window](#input\_db\_preferred\_backup\_window) | The daily time range during which automated backups are created. | `string` | `"17:00-19:00"` | no |
| <a name="input_db_start_schedule_expression"></a> [db\_start\_schedule\_expression](#input\_db\_start\_schedule\_expression) | When the rds db aurora should start. | `string` | `"cron(0 8 ? * MON-FRI *)"` | no |
| <a name="input_db_stop_enable"></a> [db\_stop\_enable](#input\_db\_stop\_enable) | Enable rds aurora shutdown. | `bool` | `false` | no |
| <a name="input_db_stop_schedule_expression"></a> [db\_stop\_schedule\_expression](#input\_db\_stop\_schedule\_expression) | When the rds db aurora should start. | `string` | `"cron(0 19 ? * MON-FRI *)"` | no |
| <a name="input_dns_record_ttl"></a> [dns\_record\_ttl](#input\_dns\_record\_ttl) | Dns record ttl (in sec) | `number` | `86400` | no |
| <a name="input_ecs_cms_image"></a> [ecs\_cms\_image](#input\_ecs\_cms\_image) | cms docker image | `string` | `"ghcr.io/pagopa/cms-pn-backend"` | no |
| <a name="input_ecs_enable_execute_command"></a> [ecs\_enable\_execute\_command](#input\_ecs\_enable\_execute\_command) | Enable to execute command inside ECS container for debugging. | `bool` | `false` | no |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | Enable/Create nat gateway | `bool` | `false` | no |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | Evnironment short. | `string` | `"d"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `string` | `"dev"` | no |
| <a name="input_fe_github_repository"></a> [fe\_github\_repository](#input\_fe\_github\_repository) | Fe repository | `string` | `"pagopa/corporate-site-fe"` | no |
| <a name="input_logs_lambda_retention"></a> [logs\_lambda\_retention](#input\_logs\_lambda\_retention) | Days to retain the log stream. | `number` | `7` | no |
| <a name="input_logs_tasks_retention"></a> [logs\_tasks\_retention](#input\_logs\_tasks\_retention) | Days to retain a log stream. | `number` | `7` | no |
| <a name="input_public_dns_zones"></a> [public\_dns\_zones](#input\_public\_dns\_zones) | Route53 Hosted Zone | `map(any)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC cidr. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_database_subnets_cidr"></a> [vpc\_database\_subnets\_cidr](#input\_vpc\_database\_subnets\_cidr) | Internal subnets list of cidr. Mainly for private endpoints | `list(string)` | <pre>[<br>  "10.0.201.0/24",<br>  "10.0.202.0/24",<br>  "10.0.203.0/24"<br>]</pre> | no |
| <a name="input_vpc_private_subnets_cidr"></a> [vpc\_private\_subnets\_cidr](#input\_vpc\_private\_subnets\_cidr) | Private subnets list of cidr. | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24",<br>  "10.0.3.0/24"<br>]</pre> | no |
| <a name="input_vpc_public_subnets_cidr"></a> [vpc\_public\_subnets\_cidr](#input\_vpc\_public\_subnets\_cidr) | Private subnets list of cidr. | `list(string)` | <pre>[<br>  "10.0.101.0/24",<br>  "10.0.102.0/24",<br>  "10.0.103.0/24"<br>]</pre> | no |

## Outputs

No outputs.
