provider "kubectl" {
  host = kind_cluster.default.server
}

resource "kind_cluster" "default" {
  name   = var.cluster_name
  config = var.multi_node ? file("${path.module}/configs/multi-node-config.yaml") : file("${path.module}/configs/single-node-config.yaml")
}

# https://docs.tigera.io/calico/latest/getting-started/kubernetes/k3s/quickstart
data "kubectl_file_documents" "calico" {
  content = file("${path.module}/configs/calico/calico.yaml")
}

resource "kubectl_manifest" "calico" {
  for_each  = data.kubectl_file_documents.calico.manifests
  yaml_body = each.value
}

data "docker_network" "kind" {
  name = "kind"

  depends_on = [
    kind_cluster.default
  ]
}


locals {
  kindIPV4Config   = [for i, config in data.docker_network.kind.ipam_config : config if config.gateway != ""][0]
  kindSubnet       = local.kindIPV4Config.subnet
  kindSubnetOctets = split(".", local.kindSubnet)


  kindv4subnet = format(
    "%d.%d.255.200-%d.%d.255.250",
    local.kindSubnetOctets[0],
    local.kindSubnetOctets[1],
    local.kindSubnetOctets[0],
    local.kindSubnetOctets[1],
  )
}

# https://kind.sigs.k8s.io/docs/user/loadbalancer/#installing-metallb-using-default-manifests
data "kubectl_file_documents" "metallb" {
  content = file("${path.module}/configs/metallb/metallb-native.yaml")
}

resource "kubectl_manifest" "metallb" {
  for_each  = data.kubectl_file_documents.metallb.manifests
  yaml_body = each.value
}


resource "kubectl_manifest" "metallb-ip-address-pool" {
  yaml_body = templatefile(
    "${path.module}/configs/metallb/metallb-ip-address-pool.yaml",
    {
      kind_ipv4_subnet = local.kindv4subnet
    }
  )

  depends_on = [
    kubectl_manifest.metallb
  ]
}

resource "kubectl_manifest" "metallb-l2-advertisement" {
  yaml_body = file("${path.module}/configs/metallb/metallb-l2-advertisement.yaml")

  depends_on = [
    kubectl_manifest.metallb-ip-address-pool
  ]
}
