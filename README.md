#Oracle Commerce environment Running On Docker

# Current Status - In progress

* Oracle Endeca Guided Search 11.1.0 - In progress

# Goals

A quick and repeatable install for development or testing purposes that can be quickly stood up using docker-compose.

# Docker

Docker is....  A container, not a VM

# Components

For those with access the Oracle files can be downloaded from https://edelivery.oracle.com.  The jdbc driver is available through http://oracle.com.

## Guided Search

Dockerfiles will be provided for OEGS 11.1.0

The following installables would need to be made available via local storage or an http location.
* V46002-01.zip - Oracle Commerce MDEX Engine (6.5.1)
* V45999-01.zip - Oracle Commerce Guided Search Platform Services (11.1.0)
*	V46389-01.zip - Oracle Commerce Experience Manager Tools and Frameworks 11.1 for Linux
* V46393-01.zip - Oracle Commerce Content Acquisition System (11.1.0)	

By default OEGS is under /appl/endeca/.  

Copy the necessary Oracle supplied zip files to the /tools folder.

Run build-oegs-11.1.0.sh shell script:

```
docker run -d -p 2222:22  -p 8006:8006 -p 8888:8888 -p 15000:15000 -p 15002:15002 -p 15010:15010 --name endeca-3.1.1 ets04uga/endeca:3.1.1
```
