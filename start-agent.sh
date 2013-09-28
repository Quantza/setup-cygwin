#! /bin/bash 
eval `ssh-agent -s` 
ssh-add $HOME/.ssh/id_rsa_g
ssh-add $HOME/.ssh/private1.key
ssh-add $HOME/.ssh/private2.key
