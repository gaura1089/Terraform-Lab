terraform {
  backend "s3" {
    bucket         = "terraform.tfstatebucket"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    # dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
