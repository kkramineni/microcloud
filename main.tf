// VMware provider details
provider "vsphere" {
  vsphere_server = "vcsa.cloudbricks.local"
  allow_unverified_ssl = true
  user = "Administrator@vsphere.local"
  password = "VMware1!"
}

// Module wise

// this module will provision 3 VMs with required configuration
module "provision" {
  source = "./modules/provision"
}

// this module configures the provisioned VMs (snap refresh, install lxd, microcloud, microceph, microovn)

module "node1" {
  source = "./modules/node1"
  depends_on = [ module.provision ]
}
module "node2" {
  source = "./modules/node2"
  depends_on = [ module.node1 ]
}
module "node3" {
  source = "./modules/node3"
  depends_on = [ module.node2 ]
}

// this module automates the "Microcloud" initialisation and configuration
module "micro_init" {
  source = "./modules/micro_init"
  depends_on = [ module.node3 ]
}