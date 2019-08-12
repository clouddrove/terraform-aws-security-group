module "security_group" {
  source        = "../"
  name          = "security-group"
  application   = "clouddrove"
  environment   = "test"
  vpc_id        = "vpc-3242342342432"
  cidr_blocks   = ["10.0.0.0/16"]
  allowed_ports = [22, 80]
}
