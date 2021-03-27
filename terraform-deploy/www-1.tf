resource "digitalocean_droplet" "www-1" {
  image = "ubuntu-18-04-x64"
  name = "www-1"
  region = "fra1"
  size = "s-1vcpu-1gb"
  private_networking = true
  ssh_keys = null
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
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
