locals {
  env        = "stg"
  account_id = "952536501111"
  region     = "ap-northeast-1"

  public_subnet_ids = [
    module.subnet.public_subnet_1a_id,
    module.subnet.public_subnet_1c_id
  ]
  private_nat_subnet_ids = [
    module.subnet.private_subnet_nat_1a_id,
    module.subnet.private_subnet_nat_1c_id
  ]
  private_subnet_ids = [
    module.subnet.private_subnet_1a_id,
    module.subnet.private_subnet_1c_id
  ]
}
