variable "data_disk_name" {
	description = "Managed Disk Name"
}
variable "data_disk_size" {
	description = "Managed Disk Size"
}

variable "zone" {
	default = "asia-south1-a" #Zone ID
}
variable "instance_name" {
	description = "Instance Name"
}
variable "instance_type" {
	description = "Instance Type"
}
variable "gce_ssh_user" {
	default = "gcp"
}
variable "bootstrap_script_path" {
  description = "path of bootstrap file"
}