#!/bin/bash -x

#
# Source environment
#
. ../etc/env.sh
. ../etc/database.sh


#
## Set the permissions on the whole installation
#

## Note: should put this in a loop and check if the directory exists first
# set ownership and permissions
chown -R ${FEDORA_USER}:${FEDORA_USER} ${REPOSITORY_HOME}
chown -R ${FEDORA_USER}:${FEDORA_USER} ${FEDORA_HOME}
chown -R ${FEDORA_USER}:${FEDORA_USER} ${SOLR_HOME}
chmod -R 755 ${REPOSITORY_HOME} 
#chmod -R 755 ${FEDORA_HOME} 
chmod 755 /etc/init.d/fedora
chmod -R 640 ${REPOSITORY_HOME}/etc
chmod 755 ${REPOSITORY_HOME}/etc
chmod -R 644 ${REPOSITORY_HOME}/etc/env.sh
