resource "digitalocean_droplet" "green" {
  count = 1
  image = "ubuntu-20-04-x64"
  name = "green-version-1.0-${count.index}"
  region = "fra1"
  size = "s-1vcpu-1gb"
  private_networking = true
  tags = ["console-1.0", "green-1.0"]
  ssh_keys = [29902027]
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = var.pvt_key
    timeout = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install nginx
      "sudo apt-get update",
      "sudo apt-get -y install nginx"
    ]
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address},' --private-key ${var.pvt_key_file} ../server-setup.yml"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo fallocate -l 1G /swapfile",
      "sudo chmod 600 /swapfile",
      "sudo mkswap /swapfile",
      "sudo swapon /swapfile"
    ]
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u sammy -i '${self.ipv4_address},' --private-key ${var.pvt_key_file} ../laravel-deploy.yml"
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u sammy -i '${self.ipv4_address},' --private-key ${var.pvt_key_file} ../server.yml -e \"dns_cloudflare_api_key=${var.cloudflare_token}\" -e \"aws_access_key=${var.aws_access_key}\" -e \"aws_secret_key=${var.aws_secret_key}\" -e \"do_instance_ip=${self.ipv4_address}\" -e \"uuid=${var.uuid}\""
  }
}

resource "cloudflare_record" "packetpigeon_green" {
  name   = "packetpigeon.com"
  value  = digitalocean_droplet.green.ipv4_address
  type = "A"
  proxied = false
  zone_id = var.cloudflare_zone_id
  count = 1
}

resource "cloudflare_record" "www_green" {
  name    = "www"
  value   = digitalocean_droplet.green.ipv4_address
  type    = "A"
  proxied = false
  zone_id = var.cloudflare_zone_id
  count = 1
}
