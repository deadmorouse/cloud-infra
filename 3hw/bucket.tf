# Bucket
resource "yandex_iam_service_account" "sa-bucket" {
  name        = "sa-bucket"
}
resource "yandex_resourcemanager_folder_iam_member" "roleassignment-storageeditor" {
  folder_id = var.yc_folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
}
resource "yandex_iam_service_account_static_access_key" "accesskey-bucket" {
  service_account_id = yandex_iam_service_account.sa-bucket.id
}
resource "yandex_kms_symmetric_key" "encryptkey" {
  name              = "encryptkey"
  default_algorithm = "AES_256"
}

resource "yandex_kms_symmetric_key_iam_binding" "encryptkey-binding" {
  symmetric_key_id = yandex_kms_symmetric_key.encryptkey.id
  role             = "kms.keys.encrypterDecrypter"
  
  members = [
    "serviceAccount:${yandex_iam_service_account.sa-bucket.id}",
  ]
}


resource "yandex_storage_bucket" "iksbucket-netology" {
  access_key = yandex_iam_service_account_static_access_key.accesskey-bucket.access_key
  secret_key = yandex_iam_service_account_static_access_key.accesskey-bucket.secret_key
  bucket     = "xx555ikscheck555xx.ru"
  default_storage_class = "STANDARD"
  force_destroy = true 
  
  # Настройка публичного доступа через флаги
  anonymous_access_flags {
    read = true
    list = true
    config_read = true
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.encryptkey.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "yandex_storage_object" "netology" {
  access_key = yandex_iam_service_account_static_access_key.accesskey-bucket.access_key
  secret_key = yandex_iam_service_account_static_access_key.accesskey-bucket.secret_key
  bucket     = yandex_storage_bucket.iksbucket-netology.id
  key        = "image1.png"
  source     = "image1.png"
}

resource "yandex_dns_zone" "iks-zone" {
  folder_id = var.yc_folder_id
  name = "iks-zone"
  zone = "${var.domain_name}."
  public = true
}
resource "yandex_dns_recordset" "iks-recordset" {
  zone_id = yandex_dns_zone.iks-zone.id
  name = "${var.domain_name}."
  type = "ANAME"
  ttl = 600
  data = ["${var.domain_name}.website.yandexcloud.net"]
}
resource "yandex_dns_recordset" "iks-validation-record" {
  zone_id = yandex_dns_zone.iks-zone.id
  name = yandex_cm_certificate.iks-letsencrypt-certificate.challenges[0].dns_name
  type = yandex_cm_certificate.iks-letsencrypt-certificate.challenges[0].dns_type
  data = [yandex_cm_certificate.iks-letsencrypt-certificate.challenges[0].dns_value]
  ttl = 600
}
resource "yandex_cm_certificate" "iks-letsencrypt-certificate" {
  folder_id = var.yc_folder_id
  name = "letsencrypt-cert"
  domains = ["${var.domain_name}"]
  managed {
  challenge_type = "DNS_CNAME"
  }
}
data "yandex_cm_certificate" "iks-cm-new-certificate" {
  folder_id = var.yc_folder_id
  certificate_id = yandex_cm_certificate.iks-letsencrypt-certificate.id
  wait_validation = false
}