# Configure the DigitalOcean Provider
# export DO_PAT="***"
# terraform plan -var "do_token=${DO_PAT}"
# terraform apply -var "do_token=${DO_PAT}"

# doctl auth init -t "TOKEN"
# doctl kubernetes options versions
# Slug 1.25.4-do.0

# define private vpc network
resource "digitalocean_vpc" "myvpc" {
  name     = "minhavpc-rede"
  region   = var.do_region
  ip_range = var.do_vpc_cidr
}

# lookup exact version of k8s available
data "digitalocean_kubernetes_versions" "example" {
  version_prefix = var.k8s_version_prefix
}

resource "digitalocean_kubernetes_cluster" "k8s" {
  name   = var.k8s_cluster_name
  region = var.do_region
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = data.digitalocean_kubernetes_versions.example.latest_version

  # network
  vpc_uuid = digitalocean_vpc.myvpc.id

  node_pool {
    name       = "nodepool"
    size       = "s-4vcpu-8gb"
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 4

  }
}
