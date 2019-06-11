

resource "vsphere_virtual_machine" "swarm-master" {
  name             = "swarm-master"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 2
  memory   = 1024
  guest_id = "centos7_64Guest"
  wait_for_guest_net_timeout = 0

  scsi_type = "lsilogic-sas"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
    label = "disk0"
    attach = true    
	  path = "/swarm-master/packer-build-ubuntu-1604.vmdk"
    datastore_id = "${data.vsphere_datastore.datastore.id}"
  }
}


resource "vsphere_virtual_machine" "swarm-work1" {
  name             = "swarm-work1"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 2
  memory   = 1024
  guest_id = "centos7_64Guest"
  wait_for_guest_net_timeout = 0

  scsi_type = "lsilogic-sas"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
    label = "disk0"
    attach = true    
	  path = "/swarm-work1/packer-build-ubuntu-1604.vmdk"
    datastore_id = "${data.vsphere_datastore.datastore.id}"
  }
}


resource "vsphere_virtual_machine" "swarm-work2" {
  name             = "swarm-work2"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 2
  memory   = 1024
  guest_id = "centos7_64Guest"
  wait_for_guest_net_timeout = 0

  scsi_type = "lsilogic-sas"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
    label = "disk0"
    attach = true    
	  path = "/swarm-work2/packer-build-ubuntu-1604.vmdk"
    datastore_id = "${data.vsphere_datastore.datastore.id}"
  }
}
