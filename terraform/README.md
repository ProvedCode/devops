# Terraform

1. If you use remote state -  https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html <br />
   Or create terraform.tfvars file by variables.tf <br />
    Example: <br />
     * var_name = "value"
     * var_name_2 = "value2" 
2. terraform init -> initialize terraform
3. terraform plan -> run this command before apply!
4. terraform apply -> create infrastructure by your terraform code
5. terraform destroy -> destroy all infrastructure
 
If you want using ssh key pair for your instance - add terraform.tfvars in ec2 directory with <aws_instance_default_ssh_key_name> variable

