output "noisebridge_mastodon_ip" {
  description = "The IP address of the Noisebridge mastodon VM"
  value       = "${scaleway_ip.mastodon.ip}"
}
