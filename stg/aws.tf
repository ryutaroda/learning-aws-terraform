module "vpc" {
  source = "../modules/aws/vpc"
  env    = local.env
}

module "subnet" {
  source = "../modules/aws/subnet"
  env    = local.env
  vpc_id = module.vpc.id
}

module "internet_gateway" {
  source = "../modules/aws/igw"
  env    = local.env
  vpc_id = module.vpc.id
}

module "route_table" {
  source                   = "../modules/aws/route_table"
  env                      = local.env
  vpc_id                   = module.vpc.id
  igw_id                   = module.internet_gateway.id
  public_subnet_ids        = local.public_subnet_ids
  private_nat_subnet_ids   = local.private_nat_subnet_ids
  private_subnet_ids       = local.private_subnet_ids
  nat_network_interface_id = ""
}

module "security_group" {
  source = "../modules/aws/security_group"
  env    = local.env
  vpc_id = module.vpc.id
}

module "ecr" {
  source = "../modules/aws/ecr"
  env    = local.env
}

module "secret_manager" {
  source = "../modules/aws/secret_manager"
  env    = local.env
}
