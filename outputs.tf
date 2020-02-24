###############
# ECS Instance
################
output "this_instance_public_ip" {
  description = "The instance public ip."
  value       = module.ecs-instance.this_public_ip
}

output "this_security_group_ids" {
  description = "The security group ids in which the instance."
  value       = module.ecs-instance.this_security_group_ids
}

output "this_vswitch_id" {
  description = "The vswitch id in which the instance."
  value       = concat(module.ecs-instance.this_vswitch_id, [""])[0]
}

output "this_instance_id" {
  description = "The instance id."
  value       = concat(module.ecs-instance.this_instance_id, [""])[0]
}

output "this_instance_name" {
  description = "The instance name."
  value       = concat(module.ecs-instance.this_instance_name, [""])[0]
}

output "this_private_ip" {
  description = "The instance private ip."
  value       = concat(module.ecs-instance.this_private_ip, [""])[0]
}

output "this_instance_tags" {
  description = "The tags for this instance."
  value       = module.ecs-instance.this_instance_tags
}

output "this_image_id" {
  description = "The image ID used by this instance."
  value       = concat(module.ecs-instance.this_image_id, [""])[0]
}

output "this_instance_type" {
  description = "The instance type."
  value       = concat(module.ecs-instance.this_instance_type, [""])[0]
}

output "this_availability_zone" {
  description = "The zone id of this instance."
  value       = concat(module.ecs-instance.this_availability_zone, [""])[0]
}

output "this_system_disk_category" {
  description = "The instance system disk type."
  value       = concat(module.ecs-instance.this_system_disk_category, [""])[0]
}

output "this_system_disk_size" {
  description = "The instance system disk size."
  value       = concat(module.ecs-instance.this_system_disk_size, [""])[0]
}
