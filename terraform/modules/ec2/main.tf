resource "aws_instance" "jenkins_master" {
    ami = "ami-0d500797138456fbb"
    instance_type = var.instance_type
    vpc_security_group_ids = [var.default_sg_id]
    # user_data = file("./scripts/main.sh")
    tags = {
        Name = "Jenkins Master"
        Owner = "Batman"
        Project = "ITA DualLight Project"
    }
}
