FROM ubuntu:18.04

RUN apt-get update 
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN pip3 install --upgrade pip
RUN apt-get install -y wget
RUN apt-get install -y unzip
RUN apt-get install -y vim

#The requests library is the de facto standard for making HTTP requests in Python. It 
RUN pip3 install requests
#PyJWT is a Python library which allows you to encode and decode JSON Web Tokens (JWT)
RUN pip3 install PyJWT
#The library helps you to store logs in JSON format. Why is it important? Well, it facilitates integration with Logstash.
RUN pip3 install JSON-log-formatter
#ConfigObj is a simple but powerful config file reader and writer: an ini file round tripper. Its main feature is that it is very easy to use, with a straightforward programmer’s interface and a simple syntax for config files. It has lots of other features though
RUN pip3 install configobj


# terraform
ENV TERRORFORM_VERSION=0.11.13
RUN wget https://releases.hashicorp.com/terraform/${TERRORFORM_VERSION}/terraform_${TERRORFORM_VERSION}_linux_amd64.zip
RUN unzip terraform_${TERRORFORM_VERSION}_linux_amd64.zip -d /usr/bin

ENV PACKER_VERSION=1.4.1
ENV HOME=/root
RUN wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/bin


ENV PACKER_BUILDER_VSPHERE_VERSION=v2.3
RUN wget https://github.com/jetbrains-infra/packer-builder-vsphere/releases/download/${PACKER_BUILDER_VSPHERE_VERSION}/packer-builder-vsphere-iso.linux
RUN mv packer-builder-vsphere-iso.linux /usr/bin/
RUN chmod +x /usr/bin/packer-builder-vsphere-iso.linux

# vSphere CLI
RUN wget https://github.com/vmware/govmomi/releases/download/v0.20.0/govc_linux_amd64.gz && gunzip govc_linux_amd64.gz && mv govc_linux_amd64 /usr/local/bin/govc
RUN chmod +x /usr/local/bin/govc
ENV GOVC_INSECURE=1
ENV GOVC_USERNAME=administrator@stqiu.local
ENV GOVC_PASSWORD=Polycom\!12
ENV GOVC_URL=https://rprm121.pctc-rprmqa.com
ENV GOVC_INSECURE=true

# install tools
COPY softwares /softwares
WORKDIR /softwares
RUN chmod +x *
RUN ./VMware-ovftool-4.3.0-7948156-lin.x86_64.bundle --eulas-agreed --required

COPY terraform /terraform
WORKDIR /terraform/create
RUN chmod +x *.sh
RUN terraform init

ENV TF_LOG=DEBUG
ENV TF_LOG_PATH=/var/log/terraform.log

WORKDIR /terraform/3rd/packer-vmware-templates-master


# ansible
#RUN pip3 install ansible




# azure
#RUN pip3 install azure==2.0.0rc6
#RUN pip3 install azure==2.0.0rc6 msrestazure
