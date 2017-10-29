#!/bin/sh

echo 'Adding oc user'
useradd -p oc oc
useradd -G sudo oc
chown -R oc:oc /home/oc
source ./modsudoers.sh