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


resource "yandex_vpc_network" "default" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "prod_ru_central1_c" {
  v4_cidr_blocks = ["10.138.0.0/24"]
  zone           = "ru-central1-c"
  name = "prod_ru_central1_c"
  network_id     = "${yandex_vpc_network.default.id}"
}
resource "yandex_vpc_subnet" "prod_ru_central1_b" {
  v4_cidr_blocks = ["10.139.0.0/24"]
  zone           = "ru-central1-b"
  name = "prod_ru_central1_b"
  network_id     = "${yandex_vpc_network.default.id}"
}
resource "yandex_vpc_subnet" "prod_ru_central1_a" {
  v4_cidr_blocks = ["10.140.0.0/24"]
  zone           = "ru-central1-a"
  name = "prod_ru_central1_a"
  network_id     = "${yandex_vpc_network.default.id}"
}


resource "yandex_dns_zone" "dns_zone" {
  name        = var.zone_name
  zone             = var.zone
  public           = false
  private_networks = [yandex_vpc_network.default.id]
}