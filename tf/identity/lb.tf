
resource "yandex_alb_target_group" "identity_alb_target_group" {
  name           = var.identity_target_group_name //

  target {
    subnet_id    = var.subnet_id
    ip_address   = yandex_compute_instance.identity_app.network_interface.0.ip_address
  }
}

resource "yandex_alb_backend_group" "identity_backend_group" {
  name                     = var.identity_backend_group_name
  session_affinity {
    connection {
      source_ip = true
    }
  }

  http_backend {
    name                   = var.identity_back_end_name
    weight                 = 1
    port                   = 9011
    target_group_ids       = [yandex_alb_target_group.identity_alb_target_group.id]
    load_balancing_config {
      panic_threshold      = 90
    }
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      healthy_threshold    = 10
      unhealthy_threshold  = 15
      http_healthcheck {
        path               = "/api/status"
      }
    }
  }
}


resource "yandex_alb_http_router" "identity_http_router" {
  name   = var.identity_http_router_name
}

resource "yandex_alb_virtual_host" "identity_virtual_host" {
  name           = var.identity_virtual_host_name
  http_router_id = yandex_alb_http_router.identity_http_router.id
  authority = [var.identity_domain_name]
  modify_request_headers {
    name = "X-Forwarded-Port"
    replace = "443"
  }
  route {
    name = var.identity_route_name
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.identity_backend_group.id
        timeout          = "3s"
      }
    }
  }
}


resource "yandex_alb_load_balancer" "identity-alb" {
  name        = var.identity_alb_name

  network_id  = var.network_id

  allocation_policy {
    location {
      zone_id   = var.az
      subnet_id = var.subnet_id
    }
  }

  listener {
    name = var.identity_https_listener_name
    endpoint {
      address {
        external_ipv4_address {
            # address = yandex_vpc_address.alb_addr.external_ipv4_address.0.address
        }
      }
      ports = [ 80 ]
    }
    tls {
      default_handler  {
        http_handler {
            http_router_id = yandex_alb_http_router.identity_http_router.id
        }
        # stream_handler {
        #     backend_group_id = yandex_alb_backend_group.identity_backend_group.id
        # }
        certificate_ids = ["fpqm2crjdaa9lv96e686"] //var??
      }
      sni_handler {
        name = var.identity_sni_handler_name
        server_names = [var.identity_domain_name] // var.identity_domain_name
        handler {
            http_handler {
                http_router_id = yandex_alb_http_router.identity_http_router.id
            }
            # stream_handler {
            #     backend_group_id = yandex_alb_backend_group.identity_backend_group.id
            # }
            certificate_ids = ["fpqm2crjdaa9lv96e686"] //var??
        }
      }
    }
  }
  log_options {
    discard_rule {
      http_code_intervals = ["HTTP_2XX"]
      discard_percent = 75
    }
  }
}