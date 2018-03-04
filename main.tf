provider "aws" {
  version = "~> 1.7.1"
  region = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  max_retries = 3
}


# ---------------------------------------------------------------------------------------------------------------------
# SETUP ACCOUNT SETTINGS
# ---------------------------------------------------------------------------------------------------------------------

module "account_settings" {
  source = "./account_settings"
}

# ---------------------------------------------------------------------------------------------------------------------
# SETUP IAM
# ---------------------------------------------------------------------------------------------------------------------

module "iam" {
  source = "./iam"
}

# ---------------------------------------------------------------------------------------------------------------------
# VPC
# ---------------------------------------------------------------------------------------------------------------------

module "vpc" {
  source = "./vpc"
}

# ---------------------------------------------------------------------------------------------------------------------
# S3
# ---------------------------------------------------------------------------------------------------------------------

module "s3" {
  source = "./s3"
  domain = "project-omega-rbmrclo-1"
}

# ---------------------------------------------------------------------------------------------------------------------
# S3
# ---------------------------------------------------------------------------------------------------------------------

module "ec2" {
  source = "./ec2"
  subnet_id = "${module.vpc.subnet_public_a_id}"
  security_group_ids = [
    "${module.vpc.vpc_default_security_group_id}",
    "${module.ec2.allow_all_security_group_id}"
  ]
}
