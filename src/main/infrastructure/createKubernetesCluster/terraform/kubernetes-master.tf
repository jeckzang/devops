
resource "vsphere_virtual_machine" "kubernetes-master" {
  name             = "kubernetes-master"
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
	  path = "/kubernetes-master/packer-build-centos-75.vmdk"
    datastore_id = "${data.vsphere_datastore.datastore.id}"
  }
}