#---------------------------------------------
#
# Environment variables 
#
#---------------------------------------------
#
export DOC_ROOT=DOC_ROOT_TO_CHANGE
export INSTALL_DIR=INSTALL_DIR_TO_CHANGE
export FEDORA_HOME=FEDORA_HOME_TO_CHANGE
export FEDORA_USER=FEDORA_USER_TO_CHANGE
export FEDORA_VERSION=FEDORA_VERSION_TO_CHANGE
export REPOSITORY_HOME=REPOSITORY_HOME_TO_CHANGE
export REPOSITORY_PKGS=$REPOSITORY_HOME/packages
export SRC_DIR=$REPOSITORY_HOME/src
export CATALINA_HOME=$FEDORA_HOME/tomcat
export SOLR_HOME=SOLR_HOME_TO_CHANGE
export SOLR_VERSION=SOLR_VERSION_TO_CHANGE
export GSEARCH_VERSION=GSEARCH_VERSION_TO_CHANGE
export FEDORA_START=$CATALINA_HOME/bin/startup.sh
export FEDORA_STOP=$CATALINA_HOME/bin/shutdown.sh
export DJATOKA_HOME=$REPOSITORY_PKGS/adore-djatoka-1.1
export KAKADU_HOME=$DJATOKA_HOME/bin/Linux-x86-64
export KAKADU_LIBRARY_PATH="-DLD_LIBRARY_PATH=$DJATOKA_HOME/lib/Linux-x86-64"

#---------------------------------------------
#
# JAVA environment variables 
#
#---------------------------------------------
#
export JAVA_HOME=JAVA_HOME_TO_CHANGE
export JRE_HOME=$JAVA_HOME/jre
#export JRE_HOME=$JAVA_HOME/lib/jvm/jre
export JAVA_OPTS="-Xms1024m -Xmx2048m -XX:MaxPermSize=1200m -Djavax.net.ssl.trustStore=$FEDORA_HOME/server/truststore -Djavax.net.ssl.trustStorePassword=tomcat"
# for djatoka
export JAVA_OPTS="$JAVA_OPTS -Djava.awt.headless=true -Dkakadu.home=$KAKADU_HOME -Djava.library.path=$DJATOKA_HOME/lib/Linux-x86-64 $KAKADU_LIBRARY_PATH"
#---------------------------------------------
#
# User environment variables 
#
#---------------------------------------------
#
export PATH=$REPOSITORY_HOME/bin:${REPOSITORY_HOME}/sbin:${HOME}/bin:${JAVA_HOME}/bin:${PATH}
export LD_LIBRARY_PATH=$REPOSITORY_HOME/lib:$CATALINA_HOME/lib:${HOME}/lib:$DJATOKA_HOME/lib:$DJATOKA_HOME/lib/Linux-x86-64:${LD_LIBRARY_PATH}
export LOGPATH=${CATALINA_HOME}/logs
