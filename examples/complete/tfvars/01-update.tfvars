#alicloud_kms_key
pending_window_in_days = 7

#alicloud_ram_role
document = <<EOF
		{
		  "Statement": [
			{
			  "Action": "sts:AssumeRole",
			  "Effect": "Allow",
			  "Principal": {
				"Service": [
				  "ecs.aliyuncs.com"
				]
			  }
			}
		  ],
		  "Version": "1"
		}
	  EOF

#Specify network setting
private_ip  = "172.16.0.12"
private_ips = ["172.16.0.12"]

#Specify instance basic attributes
instance_name = "update-tf-testacc-name"
tags = {
  Name = "updateECS"
}
user_data = "update-tf-user-data"

#Specify instance charge attributes
internet_charge_type       = "PayByBandwidth"
internet_max_bandwidth_out = "20"
subscription = {
  period             = 1
  period_unit        = "Week"
  renewal_status     = "Normal"
  auto_renew_period  = 1
  include_data_disks = false
}
dry_run = true

#Specify instance disk setting
system_disk_size = 50
volume_tags = {
  Name = "update-ecs-bare-metal-instance"
}

#Specify instance access setting
password               = "YourPassword123!update"
kms_encrypted_password = "YourPassword123!update"

// Security Setting
deletion_protection = false
force_delete        = true