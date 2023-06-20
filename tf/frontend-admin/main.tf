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

data "yandex_iam_service_account" "deployer-admin" {
  name = var.service_acc_name
}


// Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "sa-admin-tf-bucket-static-key" {
  service_account_id = data.yandex_iam_service_account.deployer-admin.id
}

resource "yandex_storage_bucket" "front_admin_bucket" {
  bucket = var.front_backet_name
  acl    = "public-read"
  force_destroy = true

  access_key = yandex_iam_service_account_static_access_key.sa-admin-tf-bucket-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-admin-tf-bucket-static-key.secret_key
  website {
    index_document = var.index_page // var.index_page
    error_document = var.error_page // var.error_page
  }
}