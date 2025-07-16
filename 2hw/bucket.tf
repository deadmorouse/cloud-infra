
resource "yandex_iam_service_account" "netology" {
    name      = "sa-for-bucket"
}

resource "yandex_resourcemanager_cloud_iam_member" "sa-bucket-admin" {
  cloud_id = var.yandex_cloud_id
  role     = "storage.admin"
  member   = "serviceAccount:${yandex_iam_service_account.netology.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "bucket-editor" {
    folder_id = var.yandex_folder_id
    role      = "storage.editor"
    member    = "serviceAccount:${yandex_iam_service_account.netology.id}"
    depends_on = [yandex_iam_service_account.netology]
}

// Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
    service_account_id = yandex_iam_service_account.netology.id
    description        = "static access key for bucket"
}

// Use keys to create bucket
resource "yandex_storage_bucket" "netology-bucket" {
    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    bucket = "iks-test-buckeet5555"
    acl    = "public-read"
      depends_on = [
    yandex_resourcemanager_cloud_iam_member.sa-bucket-admin
  ]
}

// Add picture to bucket
resource "yandex_storage_object" "object-1" {
    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    bucket = yandex_storage_bucket.netology-bucket.bucket
    key = "image1.png"
    source = "data/image1.png"
    acl    = "public-read"
    depends_on = [yandex_storage_bucket.netology-bucket]
}