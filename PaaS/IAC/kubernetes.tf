variable "digitalocean_token" {}

# Configure the Digital Ocean Provider
provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

#  Resources
## Create a new ssh key
resource "digitalocean_ssh_key" "default" {
  name       = "my ssh key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

## Create etcd Nodes
resource "digitalocean_droplet" "etcd" {
  count    = 2

  name     = "etcd-${count.index}"
  image    = "ubuntu-16-04-x64"
  size     = "s-1vcpu-1gb"
  region   = "lon1"
  ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
}

## Create controlplane Nodes
resource "digitalocean_droplet" "controlplane" {
  count    = 2

  name     = "controlplane-${count.index}"
  image    = "ubuntu-16-04-x64"
  size     = "s-1vcpu-1gb"
  region   = "lon1"
  ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
}

## Create worker Nodes
resource "digitalocean_droplet" "worker" {
  count    = 2

  name     = "worker-${count.index}"
  image    = "ubuntu-16-04-x64"
  size     = "s-1vcpu-1gb"
  region   = "lon1"
  ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
}

## Create NGINX Load Balancer server
resource "digitalocean_droplet" "loadbalancer" {
  name     = "loadbalancer"
  image    = "ubuntu-18-10-x64"
  size     = "s-1vcpu-1gb"
  region   = "lon1"
  ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
}