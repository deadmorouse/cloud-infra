output "picture_url" {
  value = "https://${yandex_storage_bucket.iksbucket-netology.bucket_domain_name}/${yandex_storage_object.netology.key}"
}
