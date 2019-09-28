# main.tf

# Configure the OpenStack Provider
provider "openstack" {
  user_name   = "admin"
  tenant_name = "admin"
  password    = "pwd"
  auth_url    = "http://myauthurl:5000/v2.0"
  region      = "RegionOne"
}

#  Resources
## Create a new ssh key
resource "openstack_ssh_key" "default" {
  name       = "my ssh key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

## Create a new OpenStack Droplet using the SSH key
resource "openstack_droplet" "node1" {
  name     = "node1"
  image    = "ubuntu-16-04-x64"
  size     = "s-1vcpu-1gb"
  region   = "lon1"
  ssh_keys = ["${openstack_ssh_key.default.fingerprint}"]
}