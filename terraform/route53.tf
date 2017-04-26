provider "aws" {
  region = "us-west-1"
  profile = "personal"
  assume_role = {
    role_arn = "arn:aws:iam::203360880603:role/terraform"
  }
}

resource "aws_route53_zone" "noisebridge_social" {
  name = "noisebridge.social."
}

resource "aws_route53_record" "dkim" {
  zone_id = "${aws_route53_zone.noisebridge_social.id}"
  name = "scph0417._domainkey.noisebridge.social"
  type = "TXT"
  ttl = "300"
  records = ["v=DKIM1; k=rsa; h=sha256; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDBXKE4rCVndowhYYwrC1N/xWtNcMlL1Vw6cb7F1ZJKlKVcJCmfW9TMAnMwUoxkitj8h7o5O5gy+6dgMKqQ+KOkyMB2GNOaqC8l1QlKED7e5rVft/sVvgf3lEB1qOQ5fLasBqt1g1r8R7p3yFMb8FwXiBRlZz8NGYPIh55TH/R8ZwIDAQAB"]
}

resource "aws_route53_record" "apex" {
  zone_id = "${aws_route53_zone.noisebridge_social.id}"
  name = "noisebridge.social"
  type = "A"
  ttl = "300"
  records = ["${scaleway_ip.mastodon.ip}"]
}

resource "aws_route53_record" "mx" {
  zone_id = "${aws_route53_zone.noisebridge_social.id}"
  name = "noisebridge.social"
  type = "MX"
  ttl = "300"
  records = ["10 noisebridge.social"]
}

resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.noisebridge_social.id}"
  name = "www.noisebridge.social"
  type = "CNAME"
  ttl = "300"
  records = ["noisebridge.social"]
}
