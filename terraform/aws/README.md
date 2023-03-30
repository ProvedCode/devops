# Terraform settings for AWS

1. Create S3 & dynamo db with names: bucket = "ita-duallight-project" dynamodb_table = "ita-duallight-project-terraform-state" or use account where this is existing
2. If you use remote state -  https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html or use aws cli
7. Create ./terraform.tfvars file by variables.tf
8. If you want using ssh key pair for your instance - add ./ec2/terraform.tfvars with <aws_instance_default_ssh_key_name> variable


# Terraform commands:

1. terraform init -> initialize terraform
2. terraform plan -> run this command before apply!
3. terraform apply -> create infrastructure by your terraform code
4. terraform destroy -> destroy all infrastructure
