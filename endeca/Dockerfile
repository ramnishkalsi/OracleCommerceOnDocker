FROM oraclelinux:7.1
MAINTAINER Ramnish Kalsi <ramnish.kalsi@gmail.com>

# ENV VARIABLES
ENV ZIP_MDEX  V861206-01.zip
ENV ZIP_PS    V861203-01.zip
ENV ZIP_TF    V861200-01.zip
ENV ZIP_CAS   V861198-01.zip

ENV MDEX_INSTALLER  OCmdex11.3.0-Linux64_1186050.bin
ENV PS_INSTALLER    OCplatformservices11.3.0-Linux64.bin 
ENV CAS_INSTALLER   OCcas11.3.0-Linux64.bin
ENV MDEX_VERSION    11.3.0
ENV TF_VERSION      11.3.0

# HOST locations
ENV HOST_DIR /tmp
ENV HOST_DIR_INSTALLERS oc11_3-installers
ENV HOST_DIR_SCRIPTS scripts
ENV HOST_DIR_TOOLS tools

# VM locations
ENV VM_DIR /appl
ENV VM_DIR_ENDECA /appl/endeca
ENV VM_DIR_ENDECA_SCRIPTS /appl/endeca/bin
ENV VM_DIR_SCRIPTS scripts
ENV VM_DIR_TMP /tmp
ENV USER_HOME_DIR /home/endeca

# install necessary OS packages
RUN yum -y install which && \
    yum -y install libaio && \
    yum -y install glibc.i686 && \
    yum -y install sudo && \
    yum -y install tar && \
    yum -y install unzip.x86_64 && \
    yum -y install openssl && \
    yum -y install net-tools

RUN mkdir -p ${VM_DIR_TMP} && chmod -R 644 ${VM_DIR_TMP}
RUN mkdir -p ${VM_DIR_ENDECA_SCRIPTS} && chmod -R 755 ${VM_DIR_ENDECA_SCRIPTS}
COPY ${HOST_DIR_SCRIPTS}/*.sh /
COPY ${HOST_DIR_SCRIPTS}/*.xml /
COPY ${HOST_DIR_SCRIPTS}/*.properties /
RUN chmod +x /*.sh
RUN /setup.sh

#######################################
# 1. MDEX INSTALLATION
COPY $HOST_DIR_INSTALLERS/$ZIP_MDEX ${VM_DIR_TMP}/$ZIP_MDEX
RUN unzip $VM_DIR_TMP/$ZIP_MDEX -d $VM_DIR_TMP
RUN chmod +x $VM_DIR_TMP/$MDEX_INSTALLER
RUN $VM_DIR_TMP/$MDEX_INSTALLER -i silent -f /mdex_response.properties
RUN /setup2.sh
ENV ENDECA_MDEX_ROOT ${VM_DIR_ENDECA}/MDEX/${MDEX_VERSION}
ENV PATH ${ENDECA_MDEX_ROOT}/bin:$PATH

# 2: Platform services
COPY $HOST_DIR_INSTALLERS/$ZIP_PS  $VM_DIR_TMP/.
RUN unzip $VM_DIR_TMP/$ZIP_PS -d $VM_DIR_TMP
RUN chmod +x /tmp/$PS_INSTALLER
RUN $VM_DIR_TMP/$PS_INSTALLER -i silent -f /ps_response.properties
RUN cat ${VM_DIR_ENDECA}/PlatformServices/workspace/setup/installer_sh.ini >> ${USER_HOME_DIR}/.bashrc
RUN source ${USER_HOME_DIR}/.bashrc

# 3. Tools & Frameworks 
COPY $HOST_DIR_INSTALLERS/$ZIP_TF  $VM_DIR_TMP/.
RUN unzip $VM_DIR_TMP/$ZIP_TF -d $VM_DIR_TMP
RUN chmod 777 $VM_DIR_TMP
RUN chmod -R 755 $VM_DIR_TMP/cd
RUN chown -R endeca:endeca $VM_DIR_TMP/cd
RUN chown -R endeca:endeca $VM_DIR_ENDECA/
RUN chown -R endeca:endeca $USER_HOME_DIR
RUN sed -i "s/dba/endeca/" $VM_DIR_TMP/cd/Disk1/install/silent_response.rsp
RUN su -m endeca -c '$VM_DIR_TMP/cd/Disk1/install/silent_install.sh $VM_DIR_TMP/cd/Disk1/install/silent_response.rsp ToolsAndFrameworks $VM_DIR_ENDECA/ToolsAndFrameworks'

ENV ENDECA_TOOLS_ROOT $VM_DIR_ENDECA/ToolsAndFrameworks/$TF_VERSION
ENV ENDECA_TOOLS_CONF $VM_DIR_ENDECA/ToolsAndFrameworks/$TF_VERSION/server/workspace
RUN echo 'ENDECA_TOOLS_ROOT=$VM_DIR_ENDECA/ToolsAndFrameworks/$TF_VERSION/' >> $USER_HOME_DIR/.bashrc && \
echo 'ENDECA_TOOLS_CONF=$VM_DIR_ENDECA/ToolsAndFrameworks/$TF_VERSION/server/workspace' >> $USER_HOME_DIR/.bashrc && \
source $USER_HOME_DIR/.bashrc && $USER_HOME_DIR/oraInventory/orainstRoot.sh

# 4. CAS
COPY $HOST_DIR_INSTALLERS/$ZIP_CAS  $VM_DIR_TMP/.
RUN unzip $VM_DIR_TMP/$ZIP_CAS -d $VM_DIR_TMP
RUN $VM_DIR_TMP/$CAS_INSTALLER -i silent -f /cas_response.properties

# Cleanup
RUN cd $VM_DIR_TMP
RUN rm -rf *
RUN	rm /setup*.sh
ENV AUTHORIZED_KEYS **None**

Run echo "Endeca VM is ready"

EXPOSE 22
CMD ["/bin/bash"]
