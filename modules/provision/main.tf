variable "vsphere_datacenter" {
  default = "Lab"
  description = "Datacenter"
}

data "vsphere_datacenter" "dc" {
  name = "Lab"
}
data "vsphere_datastore" "datastore" {
    name = "NVMe2"
    datacenter_id = data.vsphere_datacenter.dc.id
  
}
data "vsphere_virtual_machine" "template" {
  name  = "ubuntu2204"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_network" "network" {
  name = "cloudbricks"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_resource_pool" "pool" {
  name = "Resources"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}


resource "vsphere_virtual_machine" "vm-01" {
  name = "micro-01"
  folder = "Microcloud"
  num_cpus = 4
  num_cores_per_socket = 4
  memory = 8192
  nested_hv_enabled = true

  guest_id = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type
  firmware = data.vsphere_virtual_machine.template.firmware
  //datacenter_id = data.vsphere_datacenter.dc.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id = data.vsphere_datastore.datastore.id

  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }
  disk {
    label = "disk0"
    thin_provisioned = true
    size = data.vsphere_virtual_machine.template.disks.0.size
    unit_number = 0

  }
  disk {
    label = "disk1"
    thin_provisioned = true
    size = "300"
    unit_number = 1
  }
  
  
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "micro-01"
        domain = "cloudbricks.local"
      }
      network_interface {
        ipv4_address = "192.168.20.50"
        ipv4_netmask = "24"
      }
      ipv4_gateway = "192.168.20.254"
      dns_server_list = ["192.168.0.5"]
      dns_suffix_list = ["cloudbricks.local"]
    }
  }


}

resource "vsphere_virtual_machine" "vm-02" {
  name = "micro-02"
  folder = "Microcloud"
  num_cpus = 4
  num_cores_per_socket = 4
  memory = 8192
  nested_hv_enabled = true

  guest_id = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type
  firmware = data.vsphere_virtual_machine.template.firmware
  //datacenter_id = data.vsphere_datacenter.dc.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id = data.vsphere_datastore.datastore.id

  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }
  disk {
    label = "disk0"
    thin_provisioned = true
    size = data.vsphere_virtual_machine.template.disks.0.size
    unit_number = 0

  }
  disk {
    label = "disk1"
    thin_provisioned = true
    size = "300"
    unit_number = 1
    
  }
  
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "micro-02"
        domain = "cloudbricks.local"
      }
      network_interface {
        ipv4_address = "192.168.20.51"
        ipv4_netmask = "24"
      }
      ipv4_gateway = "192.168.20.254"
      dns_server_list = ["192.168.0.5"]
      dns_suffix_list = ["cloudbricks.local"]
    }
  }


}

resource "vsphere_virtual_machine" "vm-03" {
  name = "micro-03"
  folder = "Microcloud"
  num_cpus = 4
  num_cores_per_socket = 4
  memory = 8192
  nested_hv_enabled = true

  guest_id = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type
  firmware = data.vsphere_virtual_machine.template.firmware
  //datacenter_id = data.vsphere_datacenter.dc.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id = data.vsphere_datastore.datastore.id

  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }
  disk {
    label = "disk0"
    thin_provisioned = true
    size = data.vsphere_virtual_machine.template.disks.0.size
    unit_number = 0

  }
  disk {
    label = "disk1"
    thin_provisioned = true
    size = "300"
    unit_number = 1
  }
  
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "micro-03"
        domain = "cloudbricks.local"
      }
      network_interface {
        ipv4_address = "192.168.20.52"
        ipv4_netmask = "24"
      }
      ipv4_gateway = "192.168.20.254"
      dns_server_list = ["192.168.0.5"]
      dns_suffix_list = ["cloudbricks.local"]
    }
  }


}