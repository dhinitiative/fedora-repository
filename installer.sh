##!/bin/bash
#
# Script to automatically install a Fedora Commons server ready for an Islandora website
#

# Assumptions:
#
#
# - Make sure you set the usernames and passwords for the environment variables below. 
#     Then run the installer.sh script to complete the installation of fedora commons. 
#    % chmod 750 installer.sh; ./installer.sh

#---------------------------------------------
#
# Variable Declaration (edit for your setup)
#
#---------------------------------------------
#
#
## Set up installation variables  (CHANGE THESE BEFORE RUNNING THIS SCRIPT)
#
export SERVER_NAME=`hostname -s`                        # set server short name
export SERVER_FULL_NAME=`hostname -f`                   # set server full name
export ADMIN_EMAIL='youremail@domain.com'               # enter your email address to get messages from the server
export INSTALL_PREFIX=`pwd`
export INSTALL_DIR=/opt
export IP_ADDR=`hostname -i`                        # IP address of this server (ifconfig -a). 
#
# Software versions
#
export FEDORA_VERSION="3.8"                             # Valid versions: 3.8
export SOLR_VERSION="4.2.0"                             # Valid versions: 4.2.0
export GSEARCH_VERSION="2.6"	                        # Valid versions: 2.6
export DJATOKA_VERSION="adore"                          # Valid versions adore
#
## Variables to be passed to env.sh
export FEDORA_HOME=$INSTALL_PREFIX/fedora
export FEDORA_USER=fedora
export FEDORA_USER_PASS='fedora2014'
export REPOSITORY_HOME=$INSTALL_PREFIX
export SOLR_HOME=$INSTALL_PREFIX/solr
export JAVA_HOME=${INSTALL_PREFIX}/java
#
## Variables to be passed to database.sh
#
# Note: be careful using regular expression characters in passwords. Be sure to escape them
#
export INSTALL_CSF="No"                                # Install the CSF firewall
export ALLOW_ONLY_US="Yes"                              # Only allow US access to the server
export ROOT_MYSQL_PASS='mysqlroot'                      # If Yes to installing MySQL set the root user password
export DB_SERVER=localhost
export FEDORA_DB_NAME="fedora3"        		            # Name of fedora MySQL database -> fedora3 is recommended
export FEDORA_DB_USER="fedoradb"        		        # Fedora db username -> for fedora.fcfg file
export FEDORA_DB_PASS='fedoradbpass'        	        # Fedora db password -> for fedora.fcfg file
export FEDORA_ADMIN_USER="fedoraAdmin"                  # Username for http://localhost:8080/fedora/admin
export FEDORA_ADMIN_PASS='fedoraadminpass'              # Password for http://localhost:8080/fedora/admin
export FEDORA_GSEARCH_ADMIN_USER="fgsAdmin"             # Username for http://localhost:8080/fedoragsearch
export FEDORA_GSEARCH_ADMIN_PASS='fgsadminpass'         # Password for http://localhost:8080/fedoragsearch
export INSTALL_LOG=${INSTALL_PREFIX}/installation.log

cd $INSTALL_PREFIX

#
# Set up mail alias for root
#
yum -y install sendmail mailx
sed -i s/\#root\:/root\:/ /etc/aliases
sed -i s/marc/$ADMIN_EMAIL/ /etc/aliases
newaliases


#---------------------------------------------
#
# Configure environment variables
#
#---------------------------------------------
#
cd $REPOSITORY_HOME/sbin
./initialize_env.sh    # set islandora env and Database info
. ../etc/env.sh      # source Islandora environment
. ../etc/database.sh # source Database information


#---------------------------------------------
#
# Do the installation
#
#---------------------------------------------
#
./software_dependencies.install; ./apache.install; ./mysql.install; ./fedora.install; ./gsearch.install; ./solr.install; ./djatoka.install; ./set_permissions.sh

if [ $INSTALL_CSF == "Yes" ]; then
    #
    # Begin CSF Firewall installation
    #
    # dependancies
    #
    yum -y install bind-utils
    yum -y install perl-IO-Socket-SSL
    yum -y install perl-libwww-perl
    yum -y install perl-Crypt-SSLeay perl-Net-SSLeay

    #
    # get the package and install it
    #
    cd /tmp
    wget https://download.configserver.com/csf.tgz
    tar -zxvf csf.tgz
    cd csf 
    sh install.sh

    # 
    # now configure it
    #
    sed -i 's|TESTING = "1"|TESTING = "0"|g' /etc/csf/csf.conf
    sed -i 's|RESTRICT_SYSLOG = "0"|RESTRICT_SYSLOG = "3"|g' /etc/csf/csf.conf
    sed -i 's|SMTP_BLOCK = "0"|SMTP_BLOCK = "0"|g' /etc/csf/csf.conf
    # use the following to limit certain countries from access
    # sed -i 's|CC_DENY = ""|CC_DENY = "RU,CN,GE,BR,UA,SE,TH,CL,TW"|g' /etc/csf/csf.conf
    sed -i 's|SMTP_BLOCK = "0"|SMTP_BLOCK = "1"|g' /etc/csf/csf.conf
    sed -i 's|LF_SCRIPT_ALERT = "0"|LF_SCRIPT_ALERT = "1"|g' /etc/csf/csf.conf
    sed -i 's|SYSLOG_CHECK = "0"|SYSLOG_CHECK = "300"|g' /etc/csf/csf.conf
    sed -i 's|PT_ALL_USERS = "0"|PT_ALL_USERS = "1"|g' /etc/csf/csf.conf
    sed -i 's|PT_USERMEM = "200"|PT_USERMEM = "350"|g' /etc/csf/csf.conf
    if [ $ALLOW_ONLY_US == "Yes" ]; then
        sed -i 's|CC_ALLOW_FILTER = ""|CC_ALLOW_FILTER = "US"|g' /etc/csf/csf.conf
    fi
    # add ports
    sed -i 's|TCP_IN = "20,21,22,25,53,80,110,143,443,465,587,993,995"|TCP_IN = "20,21,22,25,53,80,443,465,587,993,995,8080,9418"|g' /etc/csf/csf.conf
    sed -i 's|TCP_OUT = "20,21,22,25,53,80,110,113,443,587,993,995"|TCP_OUT = "20,21,22,25,53,80,113,443,587,993,995,8080,9418"|g' /etc/csf/csf.conf
    #
    # update sshd
    #
    sed -i 's|#UseDNS yes|UseDNS no|g' /etc/ssh/sshd_config
    
    /bin/rm -r /tmp/csf
    /bin/rm  /tmp/csf.tgz
    #
    # update php
    #
    sed -i 's|enable_dl = On|enable_dl = Off|g' /usr/local/lib/php.ini
    #
    # update mysql (per http://dev.mysql.com/doc/mysql-security-excerpt/5.0/en/load-data-local.html)
    # 
    #
    echo "local-infile=0" >> /etc/my.cnf
fi

#
# turn off portreserve
#
service portreserve stop
chkconfig portreserve off
#
# Send email to let root (ADMIN_EMAIL) know it's complete
#
envsubst < "$REPOSITORY_HOME/etc/install-complete-email.txt" > "$REPOSITORY_HOME/installation-details.txt"
cat $REPOSITORY_HOME/installation-details.txt | mail -s "Your FEDORA COMMONS server installation details for $SERVER_FULL_NAME" $ADMIN_EMAIL
sleep 60      # make sure it gets sent before reboot
echo "Installation completed in $SECONDS seconds"
reboot
