variable "yc_token" {
  description = "Yandex Cloud OAuth token"
  type        = string
  sensitive   = true
  default     = "---"
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
  sensitive   = true
  default     = "---"
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
  sensitive   = true
  default     = "---"
}

variable "yc_zone" {
  description = "Yandex Cloud zone"
  type        = string
  default     = "---"
}

variable "domain_name" {
  type = string
  default = "xx555ikscheck555xx.ru"
  description = "Bucket name"
}