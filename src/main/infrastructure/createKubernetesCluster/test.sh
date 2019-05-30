#!/bin/bash

# create image
cd vmTemplate/centos7-with-kubernetes
packer build -var-file=vcenter.json centos7.json

# use ansible to download VM disk files to local
ansible-playbook -e "ansible_ssh_pass=Polycom123" vsphere.yml --check

# 
terraform plan -var-file=envParams/vmm.tfvars && terraform apply -var-file=envParams/vmm.tfvars

