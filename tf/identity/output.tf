output "identity_external_ip" {
  value = yandex_compute_instance.identity_app.network_interface.0.nat_ip_address
}