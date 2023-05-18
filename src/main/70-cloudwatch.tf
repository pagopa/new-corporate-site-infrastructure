resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "overall"

  dashboard_body = templatefile("${path.module}/dashboards/main.tpl.json",
    {
      aws_region                  = var.aws_region
      website_cdn_distribution_id = aws_cloudfront_distribution.website.id
      cms_media_bucket            = aws_s3_bucket.cms_media.id
      website_preview_bucket      = module.preview_bucket.name
      website_bucket              = module.website_bucket.name
      app_runner_service_id       = module.app-runner.service_id
      rds_cluster_id              = module.aurora_postgresql.cluster_id
    }
  )
}