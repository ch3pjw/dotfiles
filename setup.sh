#!/bin/bash

this_dir=$(dirname $0)

apt_cache_update_file=/var/lib/apt/periodic/update-success-stamp
update_apt=1

if [[ -e $apt_cache_update_file ]]; then
    apt_cache_updated=$(stat -c %Y /var/lib/apt/periodic/update-success-stamp)
    now=$(date +%s)
    let 'day_seconds = 60 * 60 * 24'
    let 'apt_cache_age = now - apt_cache_updated'
    if (( $apt_cache_age < $day_seconds )); then
        update_apt=0
    fi
fi

if (( $update_apt == 1 )); then
    sudo apt-get update
    sudo apt-get upgrade -y
fi

sudo apt-get install -y python3-pip python3-dev aptitude
sudo pip3 install ansible markupsafe passlib

if sudo -k -n true > /dev/null 2>&1; then
    ansible_opts=""
else
    ansible_opts="--ask-become-pass"
fi

ANSIBLE_NOCOWS=1 ansible-playbook -i "localhost," $ansible_opts ${this_dir}/setup.yml

echo "You may want to make sure your ssh key is on github:"
cat ~/.ssh/id_rsa.pub
