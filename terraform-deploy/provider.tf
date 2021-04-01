terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.7.0"
    }
  }
}

variable "do_token" {}
variable "pvt_key" {}
variable "pvt_key_file" {}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "enigma-ssh" {
  name = "enigma-ssh"
}
