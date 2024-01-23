#!/bin/bash

sudo apt-get update
sudo apt-get install git -y
sudo apt-get install python3 python3-pip python3-setuptools -y

cd ~
git clone https://github.com/sunfounder/pironman.git -b v2.0
cd ~/pironman
sudo python3 install.py
