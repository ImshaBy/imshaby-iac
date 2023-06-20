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

data "yandex_iam_service_account" "deployer" {
  name = var.service_acc_name
}

# data "yandex_resourcemanager_folder" "default_folder" {
#   name     = "default"
# }


# // Grant permissions
# resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
#   role      = "storage.editor"
#   folder_id = data.yandex_resourcemanager_folder.default_folder.id
#   member    = "serviceAccount:${data.yandex_iam_service_account.deployer.id}"
# }

// Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "sa-site-bucket-static-key" {
  service_account_id = data.yandex_iam_service_account.deployer.id
}

resource "yandex_storage_bucket" "front_site_bucket" {
  bucket = var.front_backet_name
  acl    = "public-read"
  force_destroy = true
  access_key = yandex_iam_service_account_static_access_key.sa-site-bucket-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-site-bucket-static-key.secret_key
  website {
    index_document = var.index_page // var.index_page
    error_document = var.error_page // var.error_page
  }
  anonymous_access_flags {
    config_read = false
    list        = false
    read        = true
  }

}