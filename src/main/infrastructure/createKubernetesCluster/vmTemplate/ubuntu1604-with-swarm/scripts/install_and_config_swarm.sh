#!/bin/bash

apt-get update

apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common 

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update

apt-get -y install docker-ce docker-ce-cli containerd.io

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync