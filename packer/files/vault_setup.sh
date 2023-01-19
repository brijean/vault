#! /bin/bash

#unzip and move binary to proper path
sudo unzip /tmp/vault.zip -d /usr/local/bin

#setup vault as service with systemctl
#create path structure
sudo mkdir /opt/vault
sudo mkdir /opt/vault/data
sudo mkdir /etc/vault.d
#move files to path structure
sudo cp /tmp/vault.hcl /etc/vault.d
sudo cp /tmp/vault.service /etc/systemd/system
#create users and group for vault service
sudo groupadd vault
sudo useradd vault -g vault
#assign vault ownership of vault binary
sudo chown vault /usr/local/bin/vault
sudo chgrp vault /usr/local/bin/vault
#enable vault on startup 
sudo systemctl enable vault

#set VAULT_ADDR environment variable for default uers 
sudo echo  "export VAULT_ADDR='http://127.0.0.1:8200'" >> /root/.bashrc
sudo echo  "export VAULT_ADDR='http://127.0.0.1:8200'" >> /home/ec2-user/.bashrc
