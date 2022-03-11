data "alicloud_zones" "default" {
}

data "alicloud_resource_manager_resource_groups" "default" {
}

data "alicloud_images" "default" {
  name_regex = "^ubuntu_18.*64"
}

data "alicloud_instance_types" "default" {
  availability_zone = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_ecs_key_pair" "default" {
  key_pair_name = "key_pair_name_20220310"
}

resource "alicloud_ram_role" "default" {
  name     = "tf-ram-name-20220310"
  document = var.document
}

resource "alicloud_kms_key" "kms" {
  key_usage              = "ENCRYPT/DECRYPT"
  pending_window_in_days = var.pending_window_in_days
  status                 = "Enabled"
}

resource "alicloud_kms_ciphertext" "kms" {
  plaintext = "test"
  key_id    = alicloud_kms_key.kms.id
  encryption_context = {
    test = "test"
  }
}

module "security_group" {
  source = "alibaba/security-group/alicloud"
  vpc_id = module.vpc.this_vpc_id
}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_cidr           = "172.16.0.0/16"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_zones.default.zones.0.id]
}

module "bare_metal_ecs_instance" {
  source = "../.."

  # Instance types data source variables
  bare_metal_type      = "cpu"
  instance_type_family = "ecs.ebmc6"
  cpu_core_count       = 1
  memory_size          = 2

  # Images data source variables
  most_recent      = true
  owners           = "system"
  image_name_regex = "^ubuntu_18.*64"

  # Ecs instance variables
  number_of_instances = 1

  // Specify a ecs image
  image_id  = data.alicloud_images.default.images.0.id
  image_ids = data.alicloud_images.default.ids

  // Specify instance type
  instance_type = data.alicloud_instance_types.default.instance_types.0.id

  // Specify network setting
  security_group_ids = [module.security_group.this_security_group_id]
  vswitch_id         = module.vpc.this_vswitch_ids[0]
  vswitch_ids        = module.vpc.this_vswitch_ids
  private_ip         = var.private_ip
  private_ips        = var.private_ips

  // Specify instance basic attributes
  name              = var.name
  use_num_suffix    = true
  tags              = var.tags
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.groups.0.id
  user_data         = var.user_data

  // Specify instance charge attributes
  internet_charge_type        = var.internet_charge_type
  internet_max_bandwidth_out  = var.internet_max_bandwidth_out
  associate_public_ip_address = true
  instance_charge_type        = var.instance_charge_type
  subscription                = var.subscription
  dry_run                     = var.dry_run

  // Specify instance disk setting
  system_disk_category = "cloud_efficiency"
  system_disk_size     = var.system_disk_size
  data_disks = [
    {
      name        = "example"
      size        = "20"
      encrypted   = true
      category    = "cloud_ssd"
      volume_size = 5
    }
  ]
  volume_tags = var.volume_tags

  // Specify instance access setting
  password               = var.password
  kms_encrypted_password = var.kms_encrypted_password
  kms_encryption_context = alicloud_kms_ciphertext.kms.encryption_context
  key_name               = alicloud_ecs_key_pair.default.id

  // Attach ecs instance to a RAM role
  role_name = alicloud_ram_role.default.id

  // Security Setting
  deletion_protection           = var.deletion_protection
  force_delete                  = var.force_delete
  security_enhancement_strategy = "Active"

}