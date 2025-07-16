variable "yc_token" {
  description = "Yandex Cloud OAuth token"
  type        = string
  sensitive   = true
  default     = "----"
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
  sensitive   = true
  default     = "----"
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
  sensitive   = true
  default     = "----"
}

variable "yc_zone" {
  description = "Yandex Cloud zone"
  type        = string
  default     = "ru-central1-a"
}

variable "lamp-instance-image-id" {
  default = "fd827b91d99psvq5fjit"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "----"
  description = "ssh-keygen -t ed25519"
  sensitive = true
}