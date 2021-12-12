#!/bin/bash

# install aws cli v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# remove aws cli v1
sudo rm -f /usr/bin/aws /usr/bin/aws_completer

# install postgresql13, postgresql13-contrib
sudo rpm -ivh --nodeps https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo perl -i.org -pe 's/\$releasever/7/g' /etc/yum.repos.d/pgdg-redhat-all.repo
sudo yum install -y postgresql13 postgresql13-contrib