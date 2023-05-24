resource "random_password" "cms_api_keys" {
  count   = 2
  length  = 7
  special = false
  lower   = false
}

resource "random_password" "cms_api_token_salt" {
  length  = 12
  special = false
  lower   = false
}

resource "random_password" "jwt_secrets" {
  count   = 2
  length  = 12
  special = false
  lower   = false
}

data "aws_iam_role" "app_runner_ecr_access_role" {
  name = "AppRunnerECRAccessRole"
}

locals {
  app_runner_image = join(":", [
    var.cms_public_ecr_image != null ? var.cms_public_ecr_image : aws_ecr_repository.main.repository_url,
  var.cms_image_version])
}

module "app-runner" {
  source  = "terraform-aws-modules/app-runner/aws"
  version = "1.2.0"

  service_name = local.apprunner_service_name


  auto_scaling_configurations = {
    mini = {
      name            = "mini"
      max_concurrency = 5
      max_size        = 2
      min_size        = 1

      tags = {
        Type = "Mini"
      }
    }
  }

  instance_policy_statements = {
    GetParameter = {
      actions = ["ssm:GetParameter", "ssm:GetParameters"]
      resources = [
        aws_ssm_parameter.database_password.arn,
        format("arn:aws:ssm:%s:%s:parameter/GOOGLE_OAUTH*", var.aws_region, data.aws_caller_identity.current.account_id),
        format("arn:aws:ssm:%s:%s:parameter/STRAPI*", var.aws_region, data.aws_caller_identity.current.account_id),
        format("arn:aws:ssm:%s:%s:parameter/GITHUB*", var.aws_region, data.aws_caller_identity.current.account_id),
      ]
    }

    PublishAssets = {
      actions = ["s3:DeleteObject",
        "s3:GetObject",
        "s3:GetObjectAttributes",
        "s3:ListBucket",
        "s3:PutObject",
      ]
      resources = [aws_s3_bucket.cms_media.arn]
    }
  }


  source_configuration = {
    authentication_configuration = can(regex("public", local.app_runner_image)) ? {} : {
      access_role_arn = data.aws_iam_role.app_runner_ecr_access_role.arn
    }

    auto_deployments_enabled = var.auto_deployments_enabled
    image_repository = {
      image_configuration = {
        port = local.strapi_container_port
        runtime_environment_variables = {
          APP_KEYS          = join(", ", random_password.cms_api_keys.*.result)
          API_TOKEN_SALT    = random_password.cms_api_token_salt.result
          ADMIN_JWT_SECRET  = random_password.jwt_secrets[0].result
          JWT_SECRET        = random_password.jwt_secrets[1].result
          DATABASE_CLIENT   = "postgres"
          DATABASE_HOST     = module.aurora_postgresql.cluster_endpoint
          DATABASE_PORT     = "5432"
          DATABASE_NAME     = module.aurora_postgresql.cluster_database_name
          DATABASE_USERNAME = module.aurora_postgresql.cluster_master_username
          DATABASE_SSL      = "false"
          AWS_BUCKET_NAME   = aws_s3_bucket.cms_media.id
          AWS_REGION        = var.aws_region
          CDN_BASE_URL      = format("https://%s", aws_cloudfront_distribution.media.domain_name)
          BUCKET_PREFIX     = "media"
          GOOGLE_OAUTH_REDIRECT_URI = join("/", [
            format("https://cms.%s", keys(var.public_dns_zones)[0]),
            "strapi-plugin-sso", "google", "callback"]
          )
        }

        runtime_environment_secrets = {
          DATABASE_PASSWORD          = "DB_PASSWORD"
          AWS_ACCESS_KEY_ID          = "STRAPI_IAM_ACCESS_KEY_ID"
          AWS_ACCESS_SECRET          = "STRAPI_IAM_ACCESS_SECRET"
          GOOGLE_OAUTH_CLIENT_ID     = "GOOGLE_OAUTH_CLIENT_ID"
          GOOGLE_OAUTH_CLIENT_SECRET = "GOOGLE_OAUTH_CLIENT_SECRET"
          GITHUB_TOKEN               = "GITHUB_TOKEN"
          #GITHUB_WEBHOOK             = "TODO"
        }

      }
      image_identifier      = local.app_runner_image
      image_repository_type = can(regex("public", local.app_runner_image)) ? "ECR_PUBLIC" : "ECR"
    }
  }

  create_vpc_connector          = true
  vpc_connector_subnets         = module.vpc.private_subnets
  vpc_connector_security_groups = [module.security_group.security_group_id, ]
  network_configuration = {
    ingress_configuration = {
      is_publicly_accessible = true
    }
    egress_configuration = {
      egress_type = "VPC"
    }
  }

  enable_observability_configuration = true

  health_check_configuration = {
    healthy_threshold   = 1
    interval            = 5
    path                = "/"
    protocol            = "TCP"
    timeout             = 2
    unhealthy_threshold = 5
  }

  # Custom domain
  create_custom_domain_association = true
  domain_name                      = format("cms.%s", keys(var.public_dns_zones)[0])

}

## Allow access to rds
resource "aws_security_group_rule" "app_runner_to_rds" {
  type                     = "ingress"
  from_port                = module.aurora_postgresql.cluster_port
  to_port                  = module.aurora_postgresql.cluster_port
  protocol                 = "tcp"
  security_group_id        = module.aurora_postgresql.security_group_id
  source_security_group_id = module.security_group.security_group_id
}

resource "aws_security_group_rule" "app_runner_out_rds" {
  type                     = "egress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  description              = "Allow traffic from App runner to Postgresql."
  security_group_id        = module.security_group.security_group_id
  source_security_group_id = module.aurora_postgresql.security_group_id
}

resource "aws_security_group_rule" "app_runner_out_https" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = module.security_group.security_group_id
  cidr_blocks       = ["0.0.0.0/0"]
}



resource "null_resource" "apprunner_loggroups_retention" {
  count = length(local.apprunners_loggroups)
  provisioner "local-exec" {
    command = "aws logs put-retention-policy --log-group-name ${local.apprunners_loggroups[count.index]} --retention-in-days ${var.log_apprunner_retention}"
  }

  depends_on = [
    module.app-runner
  ]
}

