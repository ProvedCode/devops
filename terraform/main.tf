provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

terraform {
  backend "s3" {
    bucket         = "ita-duallight-project"
    key            = "main/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "ita-duallight-project-terraform-state"
  }
}

# module "vpc" {
#   source = "./modules/vpc"
# }

module "sg" {
  source = "./modules/sg"
}

module "ec2" {
  source        = "./modules/ec2"
  default_sg_id = module.sg.default_sg_id
}
