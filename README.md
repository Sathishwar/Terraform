# Terraform
Terraform Example of VPC and Virtual Instance Create in GCP using Modules

### Modules:

#### VPC:

1. Using `google_compute_network` to create VPC
	```
	resource "google_compute_network" "vpc" {
 		name                    = "${var.name}-vpc"
 		auto_create_subnetworks = "false"
		}
	```
2. Create Subnets default remove `auto_create_subnetworks` line
3. Create Subnets Manually See `terraform-modules/vpc/main.tf` in create subnet block.

#### Virtual Instance:

##### Scope:

1. Create Virtual Instance
2. Create Addtinal Disk with attache Script

##### VM Module:
1. Using `google_compute_instance` to create the Virtual Instance
2. Create Addtional disk see `google_compute_disk` block
3. For SSH Connection to run Scripts or **provisioner**. See `connection` block in `terraform-modules/virtual_instance/main.tf`.
	
	Note: Change the `private_key` file path.
4. I am using `network_interface` as **default**. Modify the below code as separate VPC

	```
	module "vpc" {
  		source = "../vpc/"
	}
	```
	under `google_compute_instance` block change the `network_interface` into below code

	```
	network_interface {
    	network = "${module.vpc.vpc_name}"
    	subnetwork = "${module.vpc.subnet_name}"
    	access_config {}
  	}
	```
See More Documentation on [Terraform Site](https://www.terraform.io/docs/providers/google/index.html)

#### Test:
1. Pull the Code.
2. Create API Access JSON file in GCP Console. Too See [click here](https://cloud.google.com/storage/docs/authentication)
3. Download the JSON file and Save it some where in local
4. Modify the JSON file in `gcp/vm_create/main.tf` for `credentials`. Add exact path in `credentials` field and `vars.tf` file as `credentials_path`.
5. Go to `/gcp/vm_create` file location
6. Run `terraform init`.
7. Run `terraform plan`.
8. Run `terrafor apply`.

#### Note:
	
If remove `credentials` field from terraform backend. Run `GOOGLE_CREDENTIALS=$(cat path/credentials.json) terraform init`. 
Same follow to `terraform plan` , `terraform apply` and so. If see terraform apply logs Run `TF_LOG=ERROR terraform apply`. 
If you want more on logs use `DEBUG`, `TRACE`, `INFO`. To save the logs in particulat field add `TF_LOG_PATH=path/file.txt`
