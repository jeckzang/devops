#!/bin/bash

# create image
cd vmTemplate/centos7-with-kubernetes
packer build -var-file=vcenter.json centos7.json

# use ansible to download VM disk files to local
ansible-playbook -i ./inventories/production/ -e "ansible_user=root ansible_ssh_pass=Polycom123" site.yml --check

# 
terraform plan -var-file=envParams/vmm.tfvars && terraform apply -var-file=envParams/vmm.tfvars

