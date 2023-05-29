output "network_id" {
  value = yandex_vpc_network.default.id
}
output "default_subnet_id" {
  value = yandex_vpc_subnet.prod_ru_central1_a.id
}

output "dns_zone_id" {
  value = yandex_dns_zone.dns_zone.id
}