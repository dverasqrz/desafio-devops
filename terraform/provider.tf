terraform {
  required_version = ">= 0.14"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


# instance of the provider using personal token for access
provider "digitalocean" {
  token = var.do_token
}

# name of ssh key for cluster/droplets
# not necessary if just doing k8s cluster
data "digitalocean_ssh_key" "minhakeylinuxdesk" {
  name = "minhakeylinuxdesk"
}