resource "yandex_compute_instance" "public_instance" {
  name        = "public-instance"
  platform_id = "standard-v3"
  zone        = var.yc_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image_id
      size     = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public_subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.vms_ssh_root_key}"
  }
}

# 7. Виртуалка в приватной подсети
resource "yandex_compute_instance" "private_instance" {
  name        = "private-instance"
  platform_id = "standard-v3"
  zone        = var.yc_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image_id
      size     = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private_subnet.id
    nat       = false
  }

  metadata = {
    ssh-keys = "ubuntu:${var.vms_ssh_root_key}"
    user-data = <<-EOF
                #cloud-config

                package_update: true
                packages:
                  - traceroute
                  - sudo
                runcmd:
                  - [systemctl, restart, sshd]
                EOF
  }
}
