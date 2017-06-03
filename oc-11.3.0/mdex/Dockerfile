FROM oraclelinux:7.1
MAINTAINER Ramnish Kalsi <ramnish.kalsi@gmail.com>


#######################################
#            ENV VARIABLES            #
#######################################
ENV ZIP_MDEX V861206-01.zip
ENV MDEX_INSTALLER OCmdex11.3.0-Linux64_1186050.bin
ENV MDEX_VERSION 11.3.0

ENV HOST_BASE_DIR /tmp

# software location
ENV SOFTWARE_LOCATION /$HOST_BASE_DIR/oc11_3-installers

# endeca
ENV HOST_INSTALL_DIR_ENDECA /$HOST_INSTALL_DIR/endeca
ENV HOST_INSTALL_DIR_ENDECA_PACKAGES /$HOST_INSTALL_DIR_ENDECA/packages

# location relative to THIS script.
ENV LOCAL_SCRIPTS scripts
ENV LOCAL_TOOLS tools

ENV VM_BASE_DIR /appl
ENV VM_BASE_DIR_ENDECA /$VM_BASE_DIR/endeca
ENV VM_ENDECA_SCRIPTS_LOC /$VM_BASE_DIR_ENDECA/bin

############################################

# Step 1
# install necessary OS packages
RUN yum -y install which && \
    yum -y install libaio && \
    yum -y install glibc.i686 && \
    yum -y install sudo && \
    yum -y install tar && \
    yum -y install unzip.x86_64 && \
    yum -y install openssl && \
    yum -y install net-tools


# Step 2
# create directories for copying initial endeca packages
# directory for final install of endeca created as part of script directory
# Copy script that creates unique password for root and other scripts
RUN mkdir -p $HOST_INSTALL_DIR_ENDECA && \
chmod -R 777 $HOST_INSTALL_DIR_ENDECA && \
mkdir -p $VM_ENDECA_SCRIPTS_LOC && \
chmod -R 755 $VM_ENDECA_SCRIPTS_LOC

# Step 3
COPY $LOCAL_SCRIPTS/*.* /

# Step 4
# Set properties for scripts to be executable
RUN chmod +x /*.sh && \
chmod +x $VM_ENDECA_SCRIPTS_LOC

# Step 5
# Run commands to create endeca user and modify sudoers
RUN /setup.sh

# Step 6
# copy installer.
COPY $SOFTWARE_LOCATION/$ZIP_MDEX  $HOST_INSTALL_DIR_ENDECA_PACKAGES/.

# Step 7
# Unzip all packages to get install scripts and files
RUN unzip $HOST_INSTALL_DIR_ENDECA_PACKAGES/$ZIP_MDEX -d $HOST_INSTALL_DIR_ENDECA

# set permissions of scripts to run
RUN chmod +x $HOST_BASE_DIR/**/*.sh
RUN chmod +x $HOST_BASE_DIR/**/*.bin

#######################################
# MDEX INSTALLATION FOLLOWS
RUN $HOST_INSTALL_DIR_ENDECA_PACKAGES/$MDEX_INSTALLER --target $VM_BASE_DIR

# copy mdex environment variables to .bashrc
RUN /setup2.sh

# set mdex environment variables for rest of install
ENV ENDECA_MDEX_ROOT $VM_BASE_DIR_ENDECA/MDEX/$MDEX_VERSION
ENV PATH $ENDECA_MDEX_ROOT/bin:$PATH

ENV AUTHORIZED_KEYS **None**

EXPOSE 22
CMD ["/bin/bash"]
