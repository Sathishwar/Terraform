variable "project_name" {
	default = "project_name"
}
variable "region" {
	default = "asia-south1" #Region name
}

variable "credential_file_path" {
  default = "path/file_name.json"
}
variable "master_bootstrap_script_path" {
  description = "path of script which installs mysql"
  default     = "./../utils/scripts/mount_disk.sh"
}
