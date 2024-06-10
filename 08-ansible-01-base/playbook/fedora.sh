#!/bin/bash

read -p "Please enter the Ansible Vault password ? : " vault_password

docker run -dit --rm --name fedora pycontribs/fedora


echo ${vault_password} | ansible-playbook site.yml -i ./inventory/prod.yml --vault-password-file=/bin/cat

docker stop fedora
