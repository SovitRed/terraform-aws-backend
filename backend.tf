terraform {
  backend "s3" {
    bucket = "home-inspection-001"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}