terraform {
  cloud {
    organization = "PANW-Terraform-Labs"
    hostname     = "app.terraform.io"

    workspaces {
      name = "tf-drift-demo"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "s3bucket" {
  source = "./modules/s3-bucket"

  bucket_acl = var.bucket_acl

  versioning_enabled = var.versioning_enabled
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"

  cidr = var.vpc_cidr_block

  azs             = data.aws_availability_zones.available.names
  private_subnets = slice(var.private_subnet_cidr_blocks, 0, var.private_subnet_count)
  public_subnets  = slice(var.public_subnet_cidr_blocks, 0, var.public_subnet_count)

  enable_nat_gateway = false
  enable_vpn_gateway = var.enable_vpn_gateway

  tags = merge(var.resource_tags, {
    yor_trace = "50701cca-e711-4802-8887-07d744b15e2e"
  })
}

module "app_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/web"
  version = "3.17.0"

  name        = "web-sg-project-alpha-dev"
  description = "Security group for web-servers with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = module.vpc.public_subnets_cidr_blocks

  tags = merge(var.resource_tags, {
    yor_trace = "94802ccb-8e6a-4dab-a360-b7835aba7639"
  })
}

module "lb_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/web"
  version = "3.17.0"

  name        = "lb-sg-project-alpha-dev"
  description = "Security group for load balancer with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = merge(var.resource_tags, {
    yor_trace = "a961b2d8-c758-417b-8244-f56b510db9a0"
  })
}

