# devops

System architecture learning

# Terraform and Ansible

1. Terraform
Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.

1.1 install terraform and install vSphere CLI
# terraform
ENV TERRORFORM_VERSION=0.11.13
RUN wget https://releases.hashicorp.com/terraform/${TERRORFORM_VERSION}/terraform_${TERRORFORM_VERSION}_linux_amd64.zip
RUN unzip terraform_${TERRORFORM_VERSION}_linux_amd64.zip
RUN mv terraform /usr/bin

# vSphere CLI
RUN wget https://github.com/vmware/govmomi/releases/download/v0.20.0/govc_linux_amd64.gz && gunzip govc_linux_amd64.gz && mv govc_linux_amd64 /usr/local/bin/govc
RUN chmod +x /usr/local/bin/govc
ENV GOVC_INSECURE=1
ENV GOVC_USERNAME=${user_name}
ENV GOVC_PASSWORD=${pass_word}
ENV GOVC_URL=https://${VMM_IP}
ENV GOVC_INSECURE=true

1.2 guide for terraform
vSphere provider
https://www.terraform.io/docs/providers/vsphere/index.html

simple example for deploy EXSI VM
https://elatov.github.io/2018/07/use-terraform-to-deploy-a-vm-in-esxi/

create a VM with a exist disk
1. clone disk file from a exist VM
vmkfstools -i ubuntu.vmdk template.vmdk
2. cp template-flat.vmdk and template.vmdk to VM server template dir. This vmdk is template disk file.
3. cp template disk file to new VM folder.
4. run terraform apply

create VM with a OS image
1. install packer
ENV PACKER_VERSION=1.4.1
RUN wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/bin

2. install Packer Builder for VMware vSphere
RUN wget https://github.com/jetbrains-infra/packer-builder-vsphere/releases/download/${PACKER_BUILDER_VSPHERE_VERSION}/packer-builder-vsphere-iso.linux
RUN mkdir -p ${HOME}/packer.d/plugins
RUN mv packer-builder-vsphere-iso.linux ${HOME}/packer.d/plugins

3. build image by packer
https://medium.com/@ripon.banik/how-did-i-automate-builiding-vm-template-in-vsphere-and-run-the-vm-using-terraform-ansible-8dd302b31c25

build centos7 image step:
==> centos-75-vsphere: Creating VM...
==> centos-75-vsphere: Customizing hardware...
==> centos-75-vsphere: Mount ISO images...
==> centos-75-vsphere: Creating floppy disk...
    centos-75-vsphere: Copying files flatly from floppy_files
    centos-75-vsphere: Copying file: ./http/ks.cfg
    centos-75-vsphere: Done copying files from floppy_files
    centos-75-vsphere: Collecting paths from floppy_dirs
    centos-75-vsphere: Resulting paths from floppy_dirs : []
    centos-75-vsphere: Done copying paths from floppy_dirs
==> centos-75-vsphere: Uploading created floppy image
==> centos-75-vsphere: Adding generated Floppy...
==> centos-75-vsphere: Set boot order temporary...
==> centos-75-vsphere: Power on VM...
==> centos-75-vsphere: Waiting 10s for boot...
==> centos-75-vsphere: Typing boot command...
==> centos-75-vsphere: Waiting for IP...
==> centos-75-vsphere: IP address: 172.21.120.1
==> centos-75-vsphere: Using ssh communicator to connect: 172.21.120.1
==> centos-75-vsphere: Waiting for SSH to become available...
==> centos-75-vsphere: Connected to SSH!
==> centos-75-vsphere: Executing shutdown command...
==> centos-75-vsphere: Deleting Floppy drives...
==> centos-75-vsphere: Deleting Floppy image...
==> centos-75-vsphere: Eject CD-ROM drives...
==> centos-75-vsphere: Clear boot order...
Build 'centos-75-vsphere' finished.

# Ansible
1. install Asible











