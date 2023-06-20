
resource "yandex_cdn_origin_group" "identity_cdn_group" {
  name = "prod-identity-cdn-group" //var.cdn_origin_group_name
  use_next = true
  origin {
   source = "${yandex_alb_load_balancer.identity-alb.listener[0].endpoint[0].address[0].external_ipv4_address[0].address}:80"
  }
}

# data "yandex_cdn_origin_group" "identity_cdn_group" {
#   name = "prod-identity-cdn-group"
# }

resource "yandex_cdn_resource" "identity_cdn_resource" {
    cname = "identity.yc.imsha.by"
    origin_protocol = "http"
    active = true
    origin_group_id = yandex_cdn_origin_group.identity_cdn_group.id
    ssl_certificate {
        type = "lets_encrypt_gcore"
        # id = "fpqm2crjdaa9lv96e686"
        # certificate_id = data.yandex_cm_certificate.imshaby_certificate.id
    }
    options {
        disable_cache = true
        edge_cache_settings = 0
        # gzip_on = true
    }
}