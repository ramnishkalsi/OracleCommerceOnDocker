FROM oraclelinux:7.3
MAINTAINER Ramnish Kalsi <ramnish.kalsi@gmail.com>

# ENV VARIABLES
ENV ZIP_OC="V861209-01.zip" \
    ZIP_CRS="V861211-01.zip" \
    OC_INSTALLER="OCPlatform11.3.bin" \
    CRS_INSTALLER="OCReferenceStore11.3.bin" \
    HOST_DIR="/tmp" \
    HOST_DIR_INSTALLERS="software" \
    HOST_DIR_SCRIPTS="scripts" \
    VM_DIR="/appl" \
    VM_DIR_OC="/appl/ATG" \
    VM_DIR_OC_SCRIPTS="/appl/ATG/bin" \
    VM_DIR_SCRIPTS="scripts" \
    VM_DIR_TMP="/tmp/" \
    USER_HOME_DIR="/home/oc"

# install necessary OS packages
RUN yum -y install deltarpm && \
    yum -y install which && \
    yum -y install libaio && \
    yum -y install glibc.i686 && \
    yum -y install sudo && \
    yum -y install tar && \
    yum -y install unzip.x86_64 && \
    yum -y install openssl && \
    yum -y install net-tools && \
    yum -y install wget && \
    yum -y install curl && \
    yum -y install gzip
    

RUN mkdir -p $VM_DIR_TMP &&  \
    chmod -R 644 $VM_DIR_TMP && \
    mkdir -p $VM_DIR_OC_SCRIPTS && \
    chmod -R 755 $VM_DIR_OC_SCRIPTS
    
COPY $HOST_DIR_SCRIPTS/*.*  /

# Copy installers
COPY $HOST_DIR_INSTALLERS/*.zip $VM_DIR_TMP/

RUN chmod +x /*.sh && \
    /setup.sh

#######################################
# 1. OC INSTALLATION
RUN unzip $VM_DIR_TMP/$ZIP_OC -d $VM_DIR_TMP && \
 chmod +x $VM_DIR_TMP/$OC_INSTALLER && \
 $VM_DIR_TMP/$OC_INSTALLER -i silent -f /oc_installer_input.properties && \
 /setup2.sh


ENV AUTHORIZED_KEYS **None**

# Setup startup scripts
COPY $HOST_DIR_SCRIPTS/init* /etc/rc.d/init.d/

RUN echo "OC VM is ready!!"

EXPOSE 22

CMD  /bin/bash
     
