data "sshclient_host" "host" {
  hostname                 = digitalocean_droplet.droplet.ipv4_address
  username                 = "keyscan"
  insecure_ignore_host_key = true # we use this to scan and obtain the key
}

data "sshclient_keyscan" "keyscan" {
  host_json = data.sshclient_host.host.json
}
