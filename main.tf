terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

# Creates the module VPC
module "vpc" {
  source = "./VPCModule"
}

# Creates the module securitygroup and calls the outputs from the vpc module
module "securitygroup" {
  source = "./securitygroup"
  vpc    = module.vpc.vpc_id
}

# Creates the webserver module and calls the security group and vpc outputs
module "webserver" {
  source   = "./webserver"
  sg       = module.securitygroup.sg-id
  pub_sub  = module.vpc.pub_sub
  priv_sub = module.vpc.priv_sub
}