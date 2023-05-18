## Iam
output "strapi_user_access_key" {
  value = aws_iam_access_key.strapi.id
}

output "strapi_user_secret_key" {
  value     = aws_iam_access_key.strapi.secret
  sensitive = true
}

output "deploy_cms_role_arn" {
  value = aws_iam_role.githubdeploy.arn
}

output "deploy_website_role_arn" {
  value = aws_iam_role.deploy_website.arn
}

# Network
output "vpc_cidr" {
  value = module.vpc.vpc_cidr_block
}

## Database
output "db_cluster_database_name" {
  value = module.aurora_postgresql.cluster_database_name
}

output "db_cluster_endpoint" {
  value = module.aurora_postgresql.cluster_endpoint
}

output "db_cluster_port" {
  value = module.aurora_postgresql.cluster_port
}

output "db_cluster_master_username" {
  value     = module.aurora_postgresql.cluster_master_username
  sensitive = true
}

output "db_cluster_master_password" {
  value     = module.aurora_postgresql.cluster_master_password
  sensitive = true
}

output "cms_service_url" {
  value = module.app-runner.service_url
}

## ECR ##

output "ecr_repository_name" {
  value = aws_ecr_repository.main.name
}

output "ecr_repository_url" {
  value = aws_ecr_repository.main.repository_url
}

## Storage
output "image_s3_bucket" {
  value = aws_s3_bucket.cms_media.bucket
}

output "website_s3_bucket" {
  value = module.website_bucket.name
}

output "preview_s3_bucket" {
  value = module.preview_bucket.name
}

## CDN
output "cdn_media_domain_name" {
  value = aws_cloudfront_distribution.media.domain_name
}

output "cdn_media_id" {
  value = aws_cloudfront_distribution.media.id
}

output "cdn_website_domain_name" {
  value = aws_cloudfront_distribution.website.domain_name
}

output "cdn_website_id" {
  value = aws_cloudfront_distribution.website.id
}

/*
output "cdn_preview_domain_name" {
  value = aws_cloudfront_distribution.preview.domain_name
}


output "cdn_preview_id" {
  value = aws_cloudfront_distribution.preview.id
}
*/


## TLS Certificate Validation options
### 
output "app_runner_custom_domain_validation_records" {
  value = module.app-runner.custom_domain_association_certificate_validation_records

}

output "fe_validation_records" {
  value = aws_acm_certificate.website.domain_validation_options
}

output "www_fe_validation_records" {
  value = aws_acm_certificate.www_website.domain_validation_options
}

output "preiview_fe_validation_records" {
  value = aws_acm_certificate.preview.domain_validation_options
}

## App runner
output "app_runner_log_groups" {
  value = local.apprunners_loggroups
}

## ALB

output "alb_dns_name" {
  value = aws_lb.fe_alb.dns_name
}

# Global accellerator public ips
output "global_accellerator_ips" {
  value = aws_globalaccelerator_accelerator.alb_ga.ip_sets.*.ip_addresses
}