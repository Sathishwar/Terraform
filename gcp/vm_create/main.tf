provider "google" {
	region = "${var.region}"
	project = "${var.project_name}"
	credentials = "${file(var.credential_file_path)}"
}

terraform {
	backend "gcs" {
		credentials = "path/file_name.json"
		bucket  = "test-bucket" #Bucket Name
		prefix  = "gcp/git_test/terraform.tfstate"
	}
}
data "terraform_remote_state" "base" {
	backend = "gcs"
	config {
    	bucket = "test-bucket"
    	prefix = "gcp/git_test/common/terraform.tfstate"
    	credentials = "path/file_name.json"
  }
}

module "virtual_instance" {
	source = "../../terraform-modules/gcp/virtual_instance/"
	instance_name = "test-vm"
	instance_type = "n1-standard-2"
	data_disk_name = "test-disk"
	data_disk_size = "30"

  	#Different for Master and Slaves
  	bootstrap_script_path = "${var.master_bootstrap_script_path}"
}