variable "region" {
  default = "cn-beijing"
}
variable "profile" {
  default = "Your-Profile-Name"
}
variable "zone_id" {
  default = "cn-beijing-h"
}

provider "alicloud" {
  region  = var.region
  profile = var.profile
}

data "alicloud_vpcs" "default" {
  is_default = true
}

module "security_group" {
  source              = "alibaba/security-group/alicloud"
  region              = var.region
  profile             = var.profile
  vpc_id              = data.alicloud_vpcs.default.ids.0
  name                = "test-lex-1"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["all-all"]
}

data "alicloud_vswitches" "default" {
  is_default = true
  zone_id    = var.zone_id
}

// If there is no default vswitch, create one.
resource "alicloud_vswitch" "default" {
  count             = length(data.alicloud_vswitches.default.ids) > 0 ? 0 : 1
  availability_zone = var.zone_id
  vpc_id            = data.alicloud_vpcs.default.ids.0
  cidr_block        = cidrsubnet(data.alicloud_vpcs.default.vpcs.0.cidr_block, 4, 3)
}

module "bare_metal_ecs_instance" {
  source                      = "../../"
  region                      = var.region
  profile                     = var.profile
  name                        = "TF-bare-metal"
  instance_type_family        = "ecs.ebmc6"
  bare_metal_type             = "cpu"
  vswitch_id                  = length(data.alicloud_vswitches.default.ids) > 0 ? data.alicloud_vswitches.default.ids.0 : concat(alicloud_vswitch.default.*.id, [""])[0]
  security_group_ids          = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  internet_max_bandwidth_out  = 10
  instance_charge_type        = "PrePaid"
}