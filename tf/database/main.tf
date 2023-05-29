terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}


provider "yandex" {
  alias = "yc_ru-central1-a"
  zone = var.az
}

data "yandex_compute_image" "container-optimized-image" {
  family = "container-optimized-image"
}

resource "yandex_compute_disk" "db_disk" {
  name     =  var.db_disk_name
  type     = "network-ssd"
  zone     =  var.az
  size     =  40
  labels = {
    environment = "production"
  }
}

# ресурс "yandex_compute_instance" т.е. сервер
resource "yandex_compute_instance" "database_instances" {
  name = var.db_instance_name
  zone = var.az
  platform_id = var.platform_id
  resources {
    cores  = 2 # vCPU
    memory = 2 # RAM
  }

  boot_disk {
    auto_delete = true
    initialize_params {
      image_id = data.yandex_compute_image.container-optimized-image.id
    }
  }

  allow_stopping_for_update = true

  secondary_disk{
    disk_id = yandex_compute_disk.db_disk.id
  }

  network_interface {
    subnet_id = var.subnet_id # одна из дефолтных подсетей
    nat = true # автоматически установить динамический ip
  }

  hostname = var.db_dns_internal_name

  metadata = {
    # postgress_user = var.postgress_user
    # database_host = var.database_host
    # database_username = var.database_user
    # database_password = var.database_password
    # postgress_password = var.postgress_password
    docker-compose = file("${path.module}/docker-compose.yml")
    user-data = file("cloud_config.yaml")
  }
}

# resource "yandex_dns_recordset" "db_dns_internal" {
#   zone_id = var.dns_zone_id
#   name    = var.db_dns_internal_name
#   type    = "A"
#   ttl     = 200
#   data    = [yandex_compute_instance.database_instances.network_interface.0.ip_address]
# }





