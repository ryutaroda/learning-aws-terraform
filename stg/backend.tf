terraform {
  backend "s3" {
    bucket       = "learning-terraform-ryutaroda-stg"
    key          = "main.tfstate"
    region       = "ap-northeast-1"
  }
}
