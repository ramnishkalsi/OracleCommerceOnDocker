# Oracle Commerce environment on Docker

# Current Status - In progress

* Oracle Endeca Guided Search 11.1.0 - In progress

# Goals

A quick and repeatable install for development or testing purposes that can be quickly stood up using docker-compose.

# Containers

## OEGS Container

A container running Oracle Endeca Guided Search version 11.1.0. 

### What will be provided ?

Dockerfile and supporing shell scripts 

### What do you need to provide ?

The following installables would need to be made available via local storage or an http location.

If using local storage, copy the necessary Oracle supplied zip files to the oegs-11.1.0/oegs-installers folder.

* V46002-01.zip - Oracle Commerce MDEX Engine (6.5.1)
* V45999-01.zip - Oracle Commerce Guided Search Platform Services (11.1.0)
*	V46389-01.zip - Oracle Commerce Experience Manager Tools and Frameworks 11.1 for Linux
* V46393-01.zip - Oracle Commerce Content Acquisition System (11.1.0)	

### Installation details

OEGS is installed under /appl/endeca/.

### How do I build the container ?

Run ./build-oegs-11.1.0.sh shell script and watch the magic happen.

### How do I run the container ? - todo

```
docker run -d -p 2222:22  -p 8006:8006 -p 8888:8888 -p 15000:15000 -p 15002:15002 -p 15010:15010 --name endeca-3.1.1 ets04uga/endeca:3.1.1
```
