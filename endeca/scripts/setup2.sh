#!/bin/sh
echo 'ENDECA_MDEX_ROOT=/appl/endeca/MDEX/11.3.0' >> /home/endeca/.bashrc
echo 'export ENDECA_MDEX_ROOT' >> /home/endeca/.bashrc
echo 'PATH=$ENDECA_MDEX_ROOT/bin:$PATH' >> /home/endeca/.bashrc
echo 'export PATH' >> /home/endeca/.bashrc
source /home/endeca/.bashrc