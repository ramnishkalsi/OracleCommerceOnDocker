#!/bin/sh

echo 'Adding endeca user'
useradd -p endeca endeca
useradd -G sudo endeca

source ./modsudoers.sh