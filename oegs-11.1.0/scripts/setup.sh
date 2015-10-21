#!/bin/sh

echo 'Adding endeca user'
useradd -p endeca endeca
useradd -G sudo endeca
chown -R endeca:endeca /home/endeca
source ./modsudoers.sh