
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
  cms_http_listener_name = var.cms_http_listener_name
  identity_https_listener_name = var.identity_https_listener_name
  cms_http_router_name = var.cms_http_router_name
}

module yc_site {
  source = "./frontend-site"
  az = var.az
  front_cdn_group_name=var.front_site_cdn_group_name
  front_backet_name = var.front_site_backet_name
  index_page = var.index_site_page
  error_page = var.error_site_page
  service_acc_name = var.service_acc_name
}

module yc_admin {
  source = "./frontend-admin"
  az = var.az
  front_cdn_group_name=var.front_admin_cdn_group_name
  front_backet_name = var.front_admin_backet_name
  index_page = var.index_admin_page
  error_page = var.error_admin_page
  service_acc_name = var.service_acc_name
}

resource "yandex_alb_http_router" "site_http_router" {
  # (resource arguments)
}

resource "yandex_alb_http_router" "admin_http_router" {
  # (resource arguments)
}

resource "yandex_alb_backend_group" "site_backend_group" {
      name       = "prod-site-backend-group"


 http_backend {
 http2            = false
 name             = "imshaby-site"
 port             = 0
 storage_bucket   = "prod-web-bucket" # add link from resourse..
 target_group_ids = []
 weight           = 1
        }

      session_affinity {
           connection {
       source_ip = true
            }
        }

  # (resource arguments)
}
resource "yandex_alb_backend_group" "admin_backend_group" {
         name       = "prod-admin-backend-group"
        # (3 unchanged attributes hidden)

       http_backend {
       http2            = false
       name             = "admin-backend"
       port             = 0
       storage_bucket   = "prod-admin-bucket" # add link from resourse..
       target_group_ids = []
       weight           = 1
        }

     session_affinity {
     connection {
     source_ip = true
            }
        }

  # (resource arguments)
}
# resource "yandex_alb_virtual_host" "site_virtual_host" {
# }
# resource "yandex_alb_virtual_host" "admin_virtual_host" {
# }



