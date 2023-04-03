locals {
  vpc_name = format("%s-%s",
    var.vpc_project_name,
    "vpc"
  )

  jenkins_subnet_name = format("%s-%s",
    var.vpc_project_name,
    "jenkins-subnet"
  )
}