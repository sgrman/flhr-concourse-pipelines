
#!/bin/bash
set -x # echo on

# use caution when using -y (automatic "yes")
sudo apt -y update
sudo apt -y upgrade

# most likely is already installed
sudo apt-get install -y open-vm-tools

# common packages
sudo apt-get install -y wget git tar gawk tcpdump netcat sshpass

# install docker
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce

# use docker as non-root
sudo groupadd docker
sudo usermod -aG docker pks
sudo systemctl enable docker

# install docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# cleanup /tmp directories
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# prevent cloudconfig from preserving the original hostname
sudo sed -i 's/preserve_hostname: false/preserve_hostname: true/g' /etc/cloud/cloud.cfg

# cleanup apt
sudo apt clean

# cleans out all of the cloud-init cache / logs - this is mainly cleaning out networking info
sudo cloud-init clean --logs

# cleanup shell history
history -c
history -w
