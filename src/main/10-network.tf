data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source                = "terraform-aws-modules/vpc/aws"
  version               = "3.19.0"
  name                  = format("%s-vpc", local.project)
  cidr                  = var.vpc_cidr
  azs                   = data.aws_availability_zones.available.names
  private_subnets       = var.vpc_private_subnets_cidr
  private_subnet_suffix = "private"
  public_subnets        = var.vpc_public_subnets_cidr
  public_subnet_suffix  = "public"
  database_subnets      = var.vpc_database_subnets_cidr
  enable_nat_gateway    = var.enable_nat_gateway
  single_nat_gateway    = var.single_nat_gateway

  enable_dns_hostnames = true
  enable_dns_support   = true

}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "= 4.0"

  name        = "App runner connector"
  description = "Security group for AppRunner connector"
  vpc_id      = module.vpc.vpc_id

  egress_rules       = ["http-80-tcp", "postgresql-tcp"]
  egress_cidr_blocks = module.vpc.private_subnets_cidr_blocks

}

module "vpc_endpoints_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "= 4.0"

  name        = "cms-vpc-endpoints"
  description = "Security group for VPC Endpoints"
  vpc_id      = module.vpc.vpc_id

  egress_rules       = ["https-443-tcp"]
  egress_cidr_blocks = [module.vpc.vpc_cidr_block]

}

module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "3.19.0"

  vpc_id             = module.vpc.vpc_id
  security_group_ids = [module.vpc_endpoints_security_group.security_group_id]

  endpoints = {
    apprunner = {
      service = "apprunner.requests"
      # private_dns_enabled = true
      subnet_ids = module.vpc.private_subnets
      tags       = { Name = "cms-apprunner" }
    },
  }

}


## Application load balancer to assign the apex record.

module "alb-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "= 4.0"

  name        = "alb-sg"
  description = "Alb security group"
  vpc_id      = module.vpc.vpc_id

  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules        = ["http-80-tcp", "https-443-tcp"]
  egress_cidr_blocks  = ["0.0.0.0/0"]

}

resource "aws_lb" "fe_alb" {
  name               = format("fe-%s-alb", var.env_short)
  internal           = false
  load_balancer_type = "application" # use Application Load Balancer
  security_groups    = [module.alb-sg.security_group_id]
  subnets            = module.vpc.public_subnets
}

# listener port 80 redirects to port 443
resource "aws_alb_listener" "http_to_https" {
  load_balancer_arn = aws_lb.fe_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    order = 1
    type  = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Listener port 443 redirect to www
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_lb.fe_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.website.arn

  default_action {
    order = 2
    type  = "redirect"
    redirect {
      host        = format("www.%s", keys(var.public_dns_zones)[0])
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

## Global accellerator
resource "aws_globalaccelerator_accelerator" "alb_ga" {
  name            = format("alb-%s-ga", var.env_short)
  ip_address_type = "IPV4"
  enabled         = true

}

resource "aws_globalaccelerator_listener" "alb_ga_listener" {
  accelerator_arn = aws_globalaccelerator_accelerator.alb_ga.id
  client_affinity = "SOURCE_IP"
  protocol        = "TCP"

  port_range {
    from_port = 443
    to_port   = 443
  }

  port_range {
    from_port = 80
    to_port   = 80
  }
}

resource "aws_globalaccelerator_endpoint_group" "alb_ga_endpoint" {
  listener_arn = aws_globalaccelerator_listener.alb_ga_listener.id

  endpoint_configuration {
    endpoint_id = aws_lb.fe_alb.arn
    weight      = 100
  }
}