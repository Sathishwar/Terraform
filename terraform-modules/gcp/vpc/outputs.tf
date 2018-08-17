output "vpc_name" {
  value = "${google_compute_network.vpc.self_link}"
}
output "subnet_name" {
	value = "${google_compute_subnetwork.subnet_public.self_link}"
}

output "subnet_id" {
	value = "${google_compute_subnetwork.subnet_public.id}"
}