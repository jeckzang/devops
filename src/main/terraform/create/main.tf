
variable "vsphere_user" {
  type = "string"
}

variable "vsphere_password" {
  type = "string"
}

variable "vsphere_server" {
  type = "string"
}


provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "ha-datacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "datastore/ExtHDD2"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "cluster1/Resources"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "network/VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# resource "vsphere_file" "ubuntu_disk_flat_upload" {
#   datacenter       = "ha-datacenter"
#   datastore        = "datastore/ExtHDD2"
#   source_file      = "/terraform/create/vmTemplate/template-flat.vmdk"
#   destination_file = "/terraform-test/template-flat.vmdk"
# }

# resource "vsphere_file" "ubuntu_disk_upload" {
#   datacenter       = "ha-datacenter"
#   datastore        = "datastore/ExtHDD2"
#   source_file      = "/terraform/create/vmTemplate/template.vmdk"
#   destination_file = "/terraform-test/template.vmdk"
# }

resource "vsphere_virtual_machine" "vm" {
  name             = "terraform-test"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 2
  memory   = 1024
  guest_id = "ubuntu64Guest"
  wait_for_guest_net_timeout = 0

  scsi_type = "lsilogic"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
    label = "disk0"
    attach = true    
	  path = "/terraform-test/template.vmdk"
    datastore_id = "${data.vsphere_datastore.datastore.id}"
  }
}