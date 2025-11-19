module "ecr_app" {
  source = "../ecr_unit"
  name   = "learning-app-${var.env}"
}
