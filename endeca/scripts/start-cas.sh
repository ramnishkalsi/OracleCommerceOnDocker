#!/bin/sh
ENDECA_USER=endeca
CAS_ROOT=/appl/endeca/CAS/11.3.0
CAS_WORKSPACE=/appl/CAS/workspace

# change to user endeca
su $ENDECA_USER -c "cd $CAS_ROOT/bin; \
     $CAS_ROOT/bin/cas-service.sh >> $CAS_WORKSPACE/logs/cas-service-wrapper.log 2>&1"
