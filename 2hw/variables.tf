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
  default     = "ru-central1-a"
}

variable "lamp-instance-image-id" {
  default = "fd827b91d99psvq5fjit"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL4Oj56dSpQPYxphHBDCNXVq4ARMRJHL/qND9qELhdL8 iks@iks-K52JB"
  description = "ssh-keygen -t ed25519"
  sensitive = true
}