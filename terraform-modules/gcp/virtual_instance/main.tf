data "template_file" "bootstrap_script" {
  template = "${file("${var.bootstrap_script_path}")}"
}

// Create additional data disk

resource "google_compute_disk" "managed_data_disk" {
	name = "${var.data_disk_name}"
	type = "pd-standard"
	zone = "${var.zone}"
  size = "${var.data_disk_size}"
}
module "vpc" {
  source = "../vpc/"
}

// Create Virtual Instance Block

resource "google_compute_instance" "virtual_instance" {
  name = "${var.instance_name}"
  machine_type = "${var.instance_type}"
  zone = "${var.zone}"
  
  lifecycle {
    ignore_changes = ["boot_disk.0.initialize_params.0.image"]
  }
  
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
      size = "30"
      type = "pd-standard"
    }
  }
  network_interface {
    subnetwork = "${module.vpc.subnet_name}"
    access_config {}
  }
  attached_disk {
    source = "${google_compute_disk.managed_data_disk.name}"
    mode = "READ_WRITE"
  }
  metadata {
    sshKeys = "${var.gce_ssh_user}:${file("SSH user Public key File Path")}"
  }
  tags = ["test"]

  connection {
    type        = "ssh"
    agent       = false
    user        = "${var.gce_ssh_user}"
    timeout     = "5m"
    private_key = "${file("SSH User Private key file Path")}"
  }
  
  provisioner "file" {
    content     = "${data.template_file.bootstrap_script.rendered}"
    destination = "/tmp/bootstrap.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "bash /tmp/bootstrap.sh",
    ]
  }
}