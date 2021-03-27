resource "digitalocean_droplet" "www-1" {
  image = "ubuntu-18-04-x64"
  name = "www-1"
  region = "fra1"
  size = "s-1vcpu-1gb"
  private_networking = true
  tags = [
    "web",
    "console",
    "system",
    "release.x.y.z"
  ]
  ssh_keys = [
    29902027
  ]
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
}
