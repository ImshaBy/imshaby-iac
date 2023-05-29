output "db_external_ip" {
  value = yandex_compute_instance.database_instances.network_interface.0.nat_ip_address
}

output "db_internal_ip" {
  value = yandex_compute_instance.database_instances.network_interface.0.ip_address
}