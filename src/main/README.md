## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.4.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 4.58.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | = 4.58.0 |
| <a name="provider_aws.us-east-1"></a> [aws.us-east-1](#provider\_aws.us-east-1) | = 4.58.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb-sg"></a> [alb-sg](#module\_alb-sg) | terraform-aws-modules/security-group/aws | = 4.0 |
| <a name="module_app-runner"></a> [app-runner](#module\_app-runner) | terraform-aws-modules/app-runner/aws | 1.2.0 |
| <a name="module_aurora_postgresql"></a> [aurora\_postgresql](#module\_aurora\_postgresql) | terraform-aws-modules/rds-aurora/aws | 7.3.0 |
| <a name="module_eventbridge"></a> [eventbridge](#module\_eventbridge) | terraform-aws-modules/eventbridge/aws | 1.17.3 |
| <a name="module_lambda_function"></a> [lambda\_function](#module\_lambda\_function) | terraform-aws-modules/lambda/aws | 4.7.1 |
| <a name="module_preview_bucket"></a> [preview\_bucket](#module\_preview\_bucket) | ./modules/private_bucket |  |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | = 4.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 3.19.0 |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | terraform-aws-modules/vpc/aws//modules/vpc-endpoints | 3.19.0 |
| <a name="module_vpc_endpoints_security_group"></a> [vpc\_endpoints\_security\_group](#module\_vpc\_endpoints\_security\_group) | terraform-aws-modules/security-group/aws | = 4.0 |
| <a name="module_website_bucket"></a> [website\_bucket](#module\_website\_bucket) | ./modules/private_bucket |  |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.preview](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.website](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.www_website](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/acm_certificate) | resource |
| [aws_alb_listener.front_end](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/alb_listener) | resource |
| [aws_alb_listener.http_to_https](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/alb_listener) | resource |
| [aws_cloudfront_distribution.media](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_distribution.preview](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_distribution.website](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_function.rewrite_uri](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/cloudfront_function) | resource |
| [aws_cloudfront_origin_access_identity.main](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_cloudwatch_dashboard.main](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/cloudwatch_dashboard) | resource |
| [aws_db_parameter_group.postgresql14](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/db_parameter_group) | resource |
| [aws_ecr_lifecycle_policy.main](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.main](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/ecr_repository) | resource |
| [aws_globalaccelerator_accelerator.alb_ga](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/globalaccelerator_accelerator) | resource |
| [aws_globalaccelerator_endpoint_group.alb_ga_endpoint](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/globalaccelerator_endpoint_group) | resource |
| [aws_globalaccelerator_listener.alb_ga_listener](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/globalaccelerator_listener) | resource |
| [aws_iam_access_key.strapi](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/iam_access_key) | resource |
| [aws_iam_policy.publish_s3](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.rdsstopstart](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.upload_image](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.strapi-policy](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.deploy_ecs](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/iam_role) | resource |
| [aws_iam_role.deploy_website](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/iam_role) | resource |
| [aws_iam_role.githubdeploy](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/iam_role) | resource |
| [aws_iam_role.lambdastopstartrds](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.deploy_ec2_ecr_full_access](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.deploy_website](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambdastopstartrds](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user.strapi](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/iam_user) | resource |
| [aws_lb.fe_alb](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/lb) | resource |
| [aws_rds_cluster_parameter_group.postgresql14](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_s3_bucket.cms_media](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.cloudfront](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.preview](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.cms_media](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_versioning.cms_media](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/s3_bucket_versioning) | resource |
| [aws_security_group_rule.app_runner_out_https](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.app_runner_out_rds](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.app_runner_to_rds](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.database_password](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.strapi_iam_access_key_id](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.strapi_iam_access_secret](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/resources/ssm_parameter) | resource |
| [null_resource.apprunner_loggroups_retention](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_integer.bucket_cms_media](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [random_password.cms_api_keys](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.cms_api_token_salt](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.jwt_secrets](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy.admin_access](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.ec2_ecr_full_access](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.s3_policy_media](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_policy_preview](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_role.app_runner_ecr_access_role](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/data-sources/iam_role) | data source |
| [aws_rds_engine_version.postgresql](https://registry.terraform.io/providers/hashicorp/aws/4.58.0/docs/data-sources/rds_engine_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Corporate website. | `string` | `"website"` | no |
| <a name="input_auto_deployments_enabled"></a> [auto\_deployments\_enabled](#input\_auto\_deployments\_enabled) | App runner auto deploy enabled. | `bool` | `false` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to create resources. Default Milan | `string` | `"eu-central-1"` | no |
| <a name="input_cms_github_repository"></a> [cms\_github\_repository](#input\_cms\_github\_repository) | github repository with CMS codebase in the form organisation/repository. | `string` | `"pagopa/cms-corporate-backend"` | no |
| <a name="input_cms_image_version"></a> [cms\_image\_version](#input\_cms\_image\_version) | Tag image version to deploy | `string` | `"latest"` | no |
| <a name="input_cms_public_ecr_image"></a> [cms\_public\_ecr\_image](#input\_cms\_public\_ecr\_image) | Image name: set this name when you don't have your custom image in ECR yet | `string` | `null` | no |
| <a name="input_db_backup_retention_period"></a> [db\_backup\_retention\_period](#input\_db\_backup\_retention\_period) | The days to retain backups for. Default 7 | `number` | `7` | no |
| <a name="input_db_preferred_backup_window"></a> [db\_preferred\_backup\_window](#input\_db\_preferred\_backup\_window) | The daily time range during which automated backups are created. | `string` | `"17:00-19:00"` | no |
| <a name="input_db_start_schedule_expression"></a> [db\_start\_schedule\_expression](#input\_db\_start\_schedule\_expression) | When the rds db aurora should start. | `string` | `"cron(0 8 ? * MON-FRI *)"` | no |
| <a name="input_db_stop_enable"></a> [db\_stop\_enable](#input\_db\_stop\_enable) | Enable rds aurora shutdown. | `bool` | `false` | no |
| <a name="input_db_stop_schedule_expression"></a> [db\_stop\_schedule\_expression](#input\_db\_stop\_schedule\_expression) | When the rds db aurora should start. | `string` | `"cron(0 19 ? * MON-FRI *)"` | no |
| <a name="input_dns_record_ttl"></a> [dns\_record\_ttl](#input\_dns\_record\_ttl) | Dns record ttl (in sec) | `number` | `86400` | no |
| <a name="input_ecr_keep_nr_images"></a> [ecr\_keep\_nr\_images](#input\_ecr\_keep\_nr\_images) | Number of images to keep in ECR repository. | `number` | `3` | no |
| <a name="input_enable_cdn_https"></a> [enable\_cdn\_https](#input\_enable\_cdn\_https) | Enable ApiGw https support: the TLS certificate must be issued and verified. | `bool` | `true` | no |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | Enable/Create nat gateway | `bool` | `true` | no |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | Evnironment short. | `string` | `"d"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `string` | `"dev"` | no |
| <a name="input_fe_github_repository"></a> [fe\_github\_repository](#input\_fe\_github\_repository) | Fe repository | `string` | `"pagopa/corporate-site-fe"` | no |
| <a name="input_log_apprunner_retention"></a> [log\_apprunner\_retention](#input\_log\_apprunner\_retention) | Retention days policy related to a log group app runner | `number` | `7` | no |
| <a name="input_logs_lambda_retention"></a> [logs\_lambda\_retention](#input\_logs\_lambda\_retention) | Days to retain the log stream. | `number` | `7` | no |
| <a name="input_public_dns_zones"></a> [public\_dns\_zones](#input\_public\_dns\_zones) | Route53 Hosted Zone | `map(any)` | `null` | no |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | Single natgateway instance. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC cidr. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_database_subnets_cidr"></a> [vpc\_database\_subnets\_cidr](#input\_vpc\_database\_subnets\_cidr) | Internal subnets list of cidr. Mainly for private endpoints | `list(string)` | <pre>[<br>  "10.0.201.0/24",<br>  "10.0.202.0/24",<br>  "10.0.203.0/24"<br>]</pre> | no |
| <a name="input_vpc_private_subnets_cidr"></a> [vpc\_private\_subnets\_cidr](#input\_vpc\_private\_subnets\_cidr) | Private subnets list of cidr. | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24",<br>  "10.0.3.0/24"<br>]</pre> | no |
| <a name="input_vpc_public_subnets_cidr"></a> [vpc\_public\_subnets\_cidr](#input\_vpc\_public\_subnets\_cidr) | Private subnets list of cidr. | `list(string)` | <pre>[<br>  "10.0.101.0/24",<br>  "10.0.102.0/24",<br>  "10.0.103.0/24"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | n/a |
| <a name="output_app_runner_custom_domain_validation_records"></a> [app\_runner\_custom\_domain\_validation\_records](#output\_app\_runner\_custom\_domain\_validation\_records) | # TLS Certificate Validation options ## |
| <a name="output_app_runner_log_groups"></a> [app\_runner\_log\_groups](#output\_app\_runner\_log\_groups) | # App runner |
| <a name="output_cdn_media_domain_name"></a> [cdn\_media\_domain\_name](#output\_cdn\_media\_domain\_name) | # CDN |
| <a name="output_cdn_media_id"></a> [cdn\_media\_id](#output\_cdn\_media\_id) | n/a |
| <a name="output_cdn_preview_domain_name"></a> [cdn\_preview\_domain\_name](#output\_cdn\_preview\_domain\_name) | n/a |
| <a name="output_cdn_preview_id"></a> [cdn\_preview\_id](#output\_cdn\_preview\_id) | n/a |
| <a name="output_cdn_website_domain_name"></a> [cdn\_website\_domain\_name](#output\_cdn\_website\_domain\_name) | n/a |
| <a name="output_cdn_website_id"></a> [cdn\_website\_id](#output\_cdn\_website\_id) | n/a |
| <a name="output_cms_service_url"></a> [cms\_service\_url](#output\_cms\_service\_url) | n/a |
| <a name="output_cms_url"></a> [cms\_url](#output\_cms\_url) | n/a |
| <a name="output_db_cluster_database_name"></a> [db\_cluster\_database\_name](#output\_db\_cluster\_database\_name) | # Database |
| <a name="output_db_cluster_endpoint"></a> [db\_cluster\_endpoint](#output\_db\_cluster\_endpoint) | n/a |
| <a name="output_db_cluster_master_password"></a> [db\_cluster\_master\_password](#output\_db\_cluster\_master\_password) | n/a |
| <a name="output_db_cluster_master_username"></a> [db\_cluster\_master\_username](#output\_db\_cluster\_master\_username) | n/a |
| <a name="output_db_cluster_port"></a> [db\_cluster\_port](#output\_db\_cluster\_port) | n/a |
| <a name="output_deploy_cms_role_arn"></a> [deploy\_cms\_role\_arn](#output\_deploy\_cms\_role\_arn) | n/a |
| <a name="output_deploy_website_role_arn"></a> [deploy\_website\_role\_arn](#output\_deploy\_website\_role\_arn) | n/a |
| <a name="output_ecr_repository_name"></a> [ecr\_repository\_name](#output\_ecr\_repository\_name) | n/a |
| <a name="output_ecr_repository_url"></a> [ecr\_repository\_url](#output\_ecr\_repository\_url) | n/a |
| <a name="output_fe_validation_records"></a> [fe\_validation\_records](#output\_fe\_validation\_records) | n/a |
| <a name="output_global_accellerator_ips"></a> [global\_accellerator\_ips](#output\_global\_accellerator\_ips) | Global accellerator public ips |
| <a name="output_image_s3_bucket"></a> [image\_s3\_bucket](#output\_image\_s3\_bucket) | # Storage |
| <a name="output_preiview_fe_validation_records"></a> [preiview\_fe\_validation\_records](#output\_preiview\_fe\_validation\_records) | n/a |
| <a name="output_preview_s3_bucket"></a> [preview\_s3\_bucket](#output\_preview\_s3\_bucket) | n/a |
| <a name="output_preview_url"></a> [preview\_url](#output\_preview\_url) | n/a |
| <a name="output_strapi_user_access_key"></a> [strapi\_user\_access\_key](#output\_strapi\_user\_access\_key) | # Iam |
| <a name="output_strapi_user_secret_key"></a> [strapi\_user\_secret\_key](#output\_strapi\_user\_secret\_key) | n/a |
| <a name="output_vpc_cidr"></a> [vpc\_cidr](#output\_vpc\_cidr) | Network |
| <a name="output_website_s3_bucket"></a> [website\_s3\_bucket](#output\_website\_s3\_bucket) | n/a |
| <a name="output_website_url"></a> [website\_url](#output\_website\_url) | n/a |
| <a name="output_www_fe_validation_records"></a> [www\_fe\_validation\_records](#output\_www\_fe\_validation\_records) | n/a |
