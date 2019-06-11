#!/bin/bash

echo devops | sudo -S apt-get update

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo devops | sudo -S add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo devops | sudo -S apt-get update

echo devops | sudo -S apt-get install docker-ce docker-ce-cli containerd.io