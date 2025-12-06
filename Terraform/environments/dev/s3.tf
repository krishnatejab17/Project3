
# Create S3 bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "project3-terraform-state-828411126532"
}
