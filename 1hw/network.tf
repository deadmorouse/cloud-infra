resource "yandex_vpc_network" "vpc_network" {
  name = "test-vpc"
}


resource "yandex_vpc_subnet" "public_subnet" {
  name           = "public"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.vpc_network.id
  v4_cidr_blocks = [var.public_cidr]
}


resource "yandex_vpc_subnet" "private_subnet" {
  name           = "private"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.vpc_network.id
  v4_cidr_blocks = [var.private_cidr]
  route_table_id = yandex_vpc_route_table.nat_route.id
}


resource "yandex_vpc_route_table" "nat_route" {
  name       = "nat-route"
  network_id = yandex_vpc_network.vpc_network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.nat_ip
  }
}
