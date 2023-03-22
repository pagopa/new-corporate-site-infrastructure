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

module "app-runner" {
  source  = "terraform-aws-modules/app-runner/aws"
  version = "1.2.0"

  service_name = "cms-strapi"


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

  # IAM instance profile permissions to access secrets

  instance_policy_statements = {
    GetParameter = {
      actions   = ["ssm:GetParameter", "ssm:GetParameters"]
      resources = [aws_ssm_parameter.database_password.arn]
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

    authentication_configuration = {
      access_role_arn = data.aws_iam_role.app_runner_ecr_access_role.arn
    }

    auto_deployments_enabled = false
    image_repository = {
      image_configuration = {
        port = 1337
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
          #TODO: try to set this as secret
          DATABASE_SSL              = "false"
          AWS_ACCESS_KEY_ID         = aws_iam_access_key.strapi.id
          AWS_ACCESS_SECRET         = aws_iam_access_key.strapi.secret
          AWS_BUCKET_NAME           = aws_s3_bucket.cms_media.id
          AWS_REGION                = var.aws_region
          CDN_BASE_URL              = format("https://%s", aws_cloudfront_distribution.media.domain_name)
          BUCKET_PREFIX             = "media"
          GOOGLE_OAUTH_REDIRECT_URI = join("/", [module.app-runner.service_url, "strapi-plugin-sso", "googl", "callback"])
        }

        runtime_environment_secrets = {
          DATABASE_PASSWORD          = "DB_PASSWORD"
          GOOGLE_OAUTH_CLIENT_ID     = "GOOGLE_OAUTH_CLIENT_ID"
          GOOGLE_OAUTH_CLIENT_SECRET = "GOOGLE_OAUTH_CLIENT_SECRET"
          #GITHUB_TOKEN               = "TODO"
          #GITHUB_WEBHOOK             = "TODO"
        }

      }
      image_identifier      = join(":", [aws_ecr_repository.main.repository_url, var.cms_image_version])
      image_repository_type = "ECR"
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