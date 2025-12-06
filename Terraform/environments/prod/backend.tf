terraform {
  backend "s3" {
    bucket         = "project3-terraform-state-828411126532"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
