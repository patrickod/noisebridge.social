provider "scaleway" {
  region = "${var.region}"
}

resource "scaleway_security_group" "http" {
  name = "http"
  description = "allow HTTP(s) and SSH"
}

resource "scaleway_security_group_rule" "http_accept" {
  security_group = "${scaleway_security_group.http.id}"

  action = "accept"
  direction = "inbound"
  ip_range = "0.0.0.0/0"
  protocol = "TCP"
  port = 80
}

resource "scaleway_security_group_rule" "https_accept" {
  security_group = "${scaleway_security_group.http.id}"

  action = "accept"
  direction = "inbound"
  ip_range = "0.0.0.0/0"
  protocol = "TCP"
  port = 80
}

resource "scaleway_security_group_rule" "ssh_accept" {
  security_group = "${scaleway_security_group.http.id}"

  action = "accept"
  direction = "inbound"
  ip_range = "0.0.0.0/0"
  protocol = "TCP"
  port = 22
}

resource "scaleway_server" "mastodon" {
  name = "noisebridge.social"
  image = "${var.debian_image_id}"
  type = "VC1M"
  enable_ipv6 = "true"
  security_group = "${scaleway_security_group.http.id}"
}

resource "scaleway_ip" "mastodon" {
  server = "${scaleway_server.mastodon.id}"
}
