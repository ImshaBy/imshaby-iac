
module yc_network {
  source = "./network"
  zone = var.zone
  az = var.az
  network_name = var.network_name
  zone_name = var.zone_name
}

module yc_database {
  source = "./database"
  az = var.az
  platform_id = var.platform_id
  subnet_id = module.yc_network.default_subnet_id
  db_disk_name = var.db_disk_name
  db_dns_internal_name = var.db_dns_internal_name
  dns_zone_id = module.yc_network.dns_zone_id
  db_instance_name = var.db_instance_name
}
module yc_identity {
  source = "./identity"
  az = var.az
  platform_id = var.platform_id
  subnet_id = module.yc_network.default_subnet_id
  identity_app_name = var.identity_app_name
  network_id = module.yc_network.network_id
  identity_target_group_name = var.identity_target_group_name
  identity_backend_group_name = var.identity_backend_group_name
  identity_back_end_name = var.identity_back_end_name
  identity_http_router_name = var.identity_http_router_name
  identity_virtual_host_name = var.identity_virtual_host_name
  identity_domain_name = var.identity_domain_name
  identity_route_name = var.identity_route_name
  identity_alb_name = var.identity_alb_name
  identity_https_listener_name = var.identity_https_listener_name
  identity_sni_handler_name = var.identity_sni_handler_name
}

resource "yandex_alb_load_balancer" "identity-alb" {
  # (resource arguments)
}
