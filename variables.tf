variable "debian_image_id" {
  description = "The Image ID to use when provisioning Debian hosts"
  default = "5fc9990a-d274-49b8-afac-42af22b42a71"
}

variable "region" {
  description = "The Scaleway region into which to deploy resources"
  default = "ams1"
}
