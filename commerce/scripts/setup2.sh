#!/bin/sh
echo 'ATG_HOME=/appl/oc/ATG/ATG11.3' >> /home/oc/.bashrc
echo 'JAVA_HOME=/appl/oc/ATG/ATG11.3' >> /home/oc/.bashrc
echo 'PATH=$ENDECA_MDEX_ROOT/bin:$PATH' >> /home/endeca/.bashrc
echo 'export PATH' >> /home/endeca/.bashrc
source /home/endeca/.bashrc