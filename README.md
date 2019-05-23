# devops

System architecture learning

1. Terraform and Ansible

1.1 Terraform
Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.

1.1.1 install terraform and install vSphere CLI
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

1.1.2 guide for terraform
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
//TODO







