#!/bin/bash
#---------------------------------------------
#
# Script to initialize the settings 
# files etc/env.sh and etc/database.sh
#
#---------------------------------------------
#

sed -i "s|FEDORA_HOME_TO_CHANGE|$FEDORA_HOME|g" ../etc/env.sh
sed -i "s/FEDORA_USER_TO_CHANGE/$FEDORA_USER/g" ../etc/env.sh
sed -i "s/FEDORA_VERSION_TO_CHANGE/$FEDORA_VERSION/g" ../etc/env.sh
sed -i "s|REPOSITORY_HOME_TO_CHANGE|$REPOSITORY_HOME|g" ../etc/env.sh
sed -i "s|REPOSITORY_HOME_TO_CHANGE|$REPOSITORY_HOME|g" ../etc/init.d-fedora
sed -i "s|SOLR_HOME_TO_CHANGE|$SOLR_HOME|g" ../etc/env.sh
sed -i "s|SOLR_VERSION_TO_CHANGE|$SOLR_VERSION|g" ../etc/env.sh
sed -i "s|JAVA_HOME_TO_CHANGE|$JAVA_HOME|g" ../etc/env.sh
sed -i "s|GSEARCH_VERSION_TO_CHANGE|$GSEARCH_VERSION|g" ../etc/env.sh
sed -i "s|DOC_ROOT_TO_CHANGE|$DOC_ROOT|g" ../etc/env.sh
sed -i "s|INSTALL_DIR_TO_CHANGE|$INSTALL_DIR|g" ../etc/env.sh

sed -i "s/DATABASE_SERVER_TO_CHANGE/$DB_SERVER/g" ../etc/database.sh
sed -i "s/FULL_SERVER_NAME_TO_CHANGE/$SERVER_FULL_NAME/g" ../etc/database.sh
sed -i "s/SERVER_NAME_TO_CHANGE/$SERVER_NAME/g" ../etc/database.sh
sed -i "s/ADMIN_EMAIL_TO_CHANGE/$ADMIN_EMAIL/g" ../etc/database.sh
sed -i "s/FEDORA_DB_NAME_TO_CHANGE/$FEDORA_DB_NAME/g" ../etc/database.sh
sed -i "s/FEDORA_DB_USER_TO_CHANGE/$FEDORA_DB_USER/g" ../etc/database.sh
sed -i "s/FEDORA_DB_PASS_TO_CHANGE/$FEDORA_DB_PASS/g" ../etc/database.sh
sed -i "s/FEDORA_ADMIN_USER_TO_CHANGE/$FEDORA_ADMIN_USER/g" ../etc/database.sh
sed -i "s/FEDORA_ADMIN_PASS_TO_CHANGE/$FEDORA_ADMIN_PASS/g" ../etc/database.sh
sed -i "s/FGSADMIN_USER_TO_CHANGE/$FEDORA_GSEARCH_ADMIN_USER/g" ../etc/database.sh
sed -i "s/FGSADMIN_PASS_TO_CHANGE/$FEDORA_GSEARCH_ADMIN_PASS/g" ../etc/database.sh
