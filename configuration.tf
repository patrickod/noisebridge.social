provider "scaleway" {
  region = "${var.region}"
}

resource "scaleway_security_group" "http" {
  name        = "http"
  description = "allow HTTP(s) and SSH"
}

resource "scaleway_security_group_rule" "http_accept" {
  security_group = "${scaleway_security_group.http.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 80
}

resource "scaleway_security_group_rule" "https_accept" {
  security_group = "${scaleway_security_group.http.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 80
}

resource "scaleway_security_group_rule" "ssh_accept" {
  security_group = "${scaleway_security_group.http.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 22
}

data "scaleway_image" "debian" {
  name         = "Debian Jessie"
  architecture = "x86_64"
}

resource "scaleway_server" "mastodon" {
  name           = "noisebridge.social"
  image          = "${data.scaleway_image.debian.id}"
  type           = "VC1M"
  enable_ipv6    = "true"
  security_group = "${scaleway_security_group.http.id}"

  volume {
    size_in_gb = 50
    type       = "l_ssd"
  }
}

resource "scaleway_ip" "mastodon" {
  server = "${scaleway_server.mastodon.id}"
}
