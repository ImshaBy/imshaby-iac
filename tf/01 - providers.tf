terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tf-bucket-imshaby"
    region     = "ru-central1"
    key        = "production/common/terraform.tfstate"
    access_key = "YCAJEs4Mpc5HyfSn2j9VIt3Mb"
    secret_key = "YCPxjsAi8a8o1Q33r9Lyg2TFy4-m7Ggxj0iT-jlU"
    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1g9o0e73jl7pt139g3j/etn0fqbjochuf9pn3upv"
    dynamodb_table    = "state-lock-table"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
  required_version = ">= 0.13"
}


provider "yandex" {
  alias = "yc_ru-central1-a"
  zone = var.az
}

