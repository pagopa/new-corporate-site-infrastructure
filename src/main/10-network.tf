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

  egress_rules       = ["http-80-tcp"]
  egress_cidr_blocks = module.vpc.private_subnets_cidr_blocks

}

module "security_group_to_psql" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "= 4.0"

  name        = "App runner connector to psql"
  description = "Security group for AppRunner connector to psql"
  vpc_id      = module.vpc.vpc_id

  egress_rules       = ["postgresql-tcp"]
  egress_cidr_blocks = module.vpc.database_subnets_cidr_blocks

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
