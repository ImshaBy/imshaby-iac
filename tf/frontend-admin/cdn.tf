
# data "yandex_cdn_origin_group" "identity_cdn_group" {
#   name = "prod-identity-cdn-group"
# }

resource "yandex_cdn_origin_group" "front_admin_cdn_group" {
  name = var.front_cdn_group_name
  use_next = true
  origin {
   source = yandex_storage_bucket.front_admin_bucket.website_endpoint
  }
}


resource "yandex_cdn_resource" "front_admin_cdn_resource" {
    cname = "admin.yc.imsha.by"
    origin_protocol = "http"
    active = true
    origin_group_id = yandex_cdn_origin_group.front_admin_cdn_group.id
    ssl_certificate {
        type = "lets_encrypt_gcore"
        # id = "fpqm2crjdaa9lv96e686"
        # certificate_id = data.yandex_cm_certificate.imshaby_certificate.id
    }
    options {
        # disable_cache = true
    cors                       = [
      "$http_origin",
    ]
     redirect_http_to_https     = true

    }
}