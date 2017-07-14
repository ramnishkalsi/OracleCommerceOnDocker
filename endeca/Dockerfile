FROM oraclelinux:7.1
MAINTAINER Ramnish Kalsi <ramnish.kalsi@gmail.com>

# ENV VARIABLES
ENV ZIP_MDEX="V861206-01.zip" ZIP_PS="V861203-01.zip" ZIP_TF="V861200-01.zip" ZIP_CAS="V861198-01.zip" MDEX_INSTALLER="OCmdex11.3.0-Linux64_1186050.bin" PS_INSTALLER="OCplatformservices11.3.0-Linux64.bin" CAS_INSTALLER="OCcas11.3.0-Linux64.bin" MDEX_VERSION="11.3.0" TF_VERSION="11.3.0" HOST_DIR="/tmp" HOST_DIR_INSTALLERS="oc11_3-installers" HOST_DIR_SCRIPTS="scripts" HOST_DIR_TOOLS="tools" VM_DIR="/appl" VM_DIR_ENDECA="/appl/endeca" VM_DIR_ENDECA_SCRIPTS="/appl/endeca/bin" VM_DIR_SCRIPTS="scripts" VM_DIR_TMP="/tmp/" USER_HOME_DIR="/home/endeca" ENDECA_MDEX_ROOT="$VM_DIR_ENDECA/MDEX/$MDEX_VERSION" PATH="$ENDECA_MDEX_ROOT/bin:$PATH" ENDECA_TOOLS_ROOT="$VM_DIR_ENDECA/ToolsAndFrameworks/$TF_VERSION" ENDECA_TOOLS_CONF="$VM_DIR_ENDECA/ToolsAndFrameworks/$TF_VERSION/server/workspace" 

# install necessary OS packages
RUN yum -y install which && \
    yum -y install libaio && \
    yum -y install glibc.i686 && \
    yum -y install sudo && \
    yum -y install tar && \
    yum -y install unzip.x86_64 && \
    yum -y install openssl && \
    yum -y install net-tools && \
    yum -y install deltarpm

RUN mkdir -p $VM_DIR_TMP &&  \
    chmod -R 644 $VM_DIR_TMP && \
    mkdir -p $VM_DIR_ENDECA_SCRIPTS && \
    chmod -R 755 $VM_DIR_ENDECA_SCRIPTS
    
COPY $HOST_DIR_SCRIPTS/*  /

COPY $HOST_DIR_INSTALLERS/*.zip "$VM_DIR_TMP"

RUN chmod +x /*.sh && /setup.sh


#######################################
# MDEX
RUN unzip $VM_DIR_TMP/$ZIP_MDEX -d $VM_DIR_TMP && \
    chmod +x $VM_DIR_TMP/$MDEX_INSTALLER && \
    $VM_DIR_TMP/$MDEX_INSTALLER -i silent -f /mdex_response.properties && \
    /setup2.sh &&  \
    # Platform Services
    unzip $VM_DIR_TMP/$ZIP_PS -d $VM_DIR_TMP && \
    chmod +x /tmp/$PS_INSTALLER && \
    $VM_DIR_TMP/$PS_INSTALLER -i silent -f /ps_response.properties && \
    cat $VM_DIR_ENDECA/PlatformServices/workspace/setup/installer_sh.ini >> $USER_HOME_DIR/.bashrc && \
    source $USER_HOME_DIR/.bashrc && \
    # Tools & Frameworks 
    unzip $VM_DIR_TMP/$ZIP_TF -d $VM_DIR_TMP && \
    chmod 777 $VM_DIR_TMP && \
    chmod -R 755 $VM_DIR_TMP/cd && \
    chown -R endeca:endeca $VM_DIR_TMP/cd && \
    chown -R endeca:endeca $VM_DIR_ENDECA/ && \
    chown -R endeca:endeca $USER_HOME_DIR && \
    sed -i "s/dba/endeca/" $VM_DIR_TMP/cd/Disk1/install/silent_response.rsp && \
    su -m endeca -c '$VM_DIR_TMP/cd/Disk1/install/silent_install.sh $VM_DIR_TMP/cd/Disk1/install/silent_response.rsp ToolsAndFrameworks $VM_DIR_ENDECA/ToolsAndFrameworks' && \
    echo "ENDECA_TOOLS_ROOT=/appl/endeca/ToolsAndFrameworks/11.3.0/" >> $USER_HOME_DIR/.bashrc && \
    echo "ENDECA_TOOLS_CONF=/appl/endeca/ToolsAndFrameworks/11.3.0/server/workspace" >> $USER_HOME_DIR/.bashrc && \
    source $USER_HOME_DIR/.bashrc && $USER_HOME_DIR/oraInventory/orainstRoot.sh && \
    # CAS
    unzip $VM_DIR_TMP/$ZIP_CAS -d $VM_DIR_TMP && \
    chmod +x /tmp/$CAS_INSTALLER && \
    $VM_DIR_TMP/$CAS_INSTALLER -i silent -f /cas_response.properties && \
    chown -R endeca:endeca /appl/endeca/CAS && \
    rm -rf /$VM_DIR_TMP/*.zip && \
    rm -rf /$VM_DIR_TMP/*.bin && \
    rm -rf /$VM_DIR_TMP/cd/ && \
    rm /setup*.sh

RUN cp /init* /etc/rc.d/init.d/  && \ 
    chmod 755 /etc/rc.d/init.d/init-endeca-* && \
    chkconfig --add init-endeca-tools && \
    chkconfig --add init-endeca-ps && \
    chkconfig --add init-endeca-cas && \
    cp /start.sh $USER_HOME_DIR/ && \
    cp /start*.sh $USER_HOME_DIR/ && \
    chmod 755 $USER_HOME_DIR/start*.sh && \
    chown -R endeca:endeca $USER_HOME_DIR/ 

ENV AUTHORIZED_KEYS **None**
EXPOSE 22
WORKDIR  /home/endeca
USER    endeca

CMD  /home/endeca/start.sh && /bin/bash
