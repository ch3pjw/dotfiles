#!/bin/bash -x

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y python-pip python-dev aptitude
sudo pip install ansible markupsafe passlib

if sudo -k -n true > /dev/null 2>&1; then
    ansible_opts=""
else
    ansible_opts="--ask-sudo-pass"
fi

ANSIBLE_NOCOWS=1 ansible-playbook -i "localhost," $ansible_opts ./setup.yml
