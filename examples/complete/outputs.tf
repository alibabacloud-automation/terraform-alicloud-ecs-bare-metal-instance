###############
# ECS Instance
###############
output "this_instance_public_ip" {
  description = "The instance public ip."
  value       = module.bare_metal_ecs_instance.this_instance_public_ip
}

output "this_security_group_ids" {
  description = "The security group ids in which the instance."
  value       = module.bare_metal_ecs_instance.this_security_group_ids
}

output "this_vswitch_id" {
  description = "The vswitch id in which the instance."
  value       = module.bare_metal_ecs_instance.this_vswitch_id
}

output "this_instance_id" {
  description = "The instance id"
  value       = module.bare_metal_ecs_instance.this_instance_id
}
output "this_instance_name" {
  description = "The instance name."
  value       = module.bare_metal_ecs_instance.this_instance_name
}

output "this_private_ip" {
  description = "The instance private ip."
  value       = module.bare_metal_ecs_instance.this_private_ip
}

output "this_instance_tags" {
  description = "The tags for this instance."
  value       = module.bare_metal_ecs_instance.this_instance_tags
}

output "this_image_id" {
  description = "The image ID used by this instance."
  value       = module.bare_metal_ecs_instance.this_image_id
}

output "this_instance_type" {
  description = "The instance type."
  value       = module.bare_metal_ecs_instance.this_instance_type
}

output "this_availability_zone" {
  description = "The zone id of this instance."
  value       = module.bare_metal_ecs_instance.this_availability_zone
}

output "this_system_disk_category" {
  description = "The instance system disk type."
  value       = module.bare_metal_ecs_instance.this_system_disk_category
}

output "this_system_disk_size" {
  description = "The instance system disk size."
  value       = module.bare_metal_ecs_instance.this_system_disk_size
}
