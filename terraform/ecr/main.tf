module "ecr" {
  source              = "../modules/ecr"
  frontend_repository = var.frontend_repository
  backend_repository  = var.backend_repository
}
