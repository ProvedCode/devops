resource "aws_instance" "jenkins_master" {
  ami                    = "ami-0d500797138456fbb"
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.default_sg_id]
  user_data              = file("scripts/install-jenkins.sh")
  key_name               = var.aws_instance_default_ssh_key_name
  tags = {
    Name    = "Jenkins Master"
    Owner   = "DevOps Engineer"
    Project = "ITA DualLight Project"
  }
}
