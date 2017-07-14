# Oracle Commerce environment on Docker

# Current Status - In progress

* Oracle Endeca Guided Search 11.3.0

# Goals

A quick and repeatable install for development or testing purposes that can be quickly stood up using docker

# Containers

## Endeca Container

A container running Oracle Endeca Guided Search version 11.3.0. 

### What will be provided ?

Dockerfile and supporing shell scripts 

### What do you need to provide ?

The following installables would need to be made available via local storage. 
If using local storage, copy the necessary Oracle supplied zip files to endeca/oc11_3-installers/ folder.

V861206-01.zip 
V861203-01.zip
V861200-01.zip
V861198-01.zip


http location - TODO

### Installation details

Endeca is installed under /appl/endeca/.

### How do I build the container ?

Run ./build-oc.sh shell script and watch the magic happen.

### How do I run the container ? - todo

Run ./run-oc.sh
