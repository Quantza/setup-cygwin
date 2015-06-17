#! /bin/bash 
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/web-dev
ssh-add $HOME/.ssh/gHub_rsa
ssh-add $HOME/.ssh/ko-dev
