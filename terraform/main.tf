provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
}

terraform {
  backend "s3" {
    bucket = "ita-duallight-project"
    key = "main/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "vpc" {
  source = "./modules/vpc"
}
