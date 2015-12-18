#---------------------------------------------
#
# Database info
#
#---------------------------------------------
#
export DB_SERVER=DATABASE_SERVER_TO_CHANGE			# hostname of the MySQL server
export SERVER_NAME=SERVER_NAME_TO_CHANGE        # short hostname of this server 
export FULL_SERVER_NAME=FULL_SERVER_NAME_TO_CHANGE  # full hostname of the server for the base apache server
export ADMIN_EMAIL=ADMIN_EMAIL_TO_CHANGE            # name of admin email for drupal and apache configs

#---------------------------------------------
#
# Fedora database and user info
#
#---------------------------------------------
#
export FEDORA_DB_NAME="FEDORA_DB_NAME_TO_CHANGE"        		# Name of fedora MySQL database -> fedora3 is recommeneded
export FEDORA_DB_USER="FEDORA_DB_USER_TO_CHANGE"        		# Fedora db username -> for fedora.fcfg file
export FEDORA_DB_PASS="FEDORA_DB_PASS_TO_CHANGE"         	# Fedora db password -> for fedora.fcfg file
export FEDORA_ADMIN_USER="FEDORA_ADMIN_USER_TO_CHANGE"          # Username for http://localhost:8080/fedora/admin
export FEDORA_ADMIN_PASS="FEDORA_ADMIN_PASS_TO_CHANGE"          	# Password for http://localhost:8080/fedora/admin
#---------------------------------------------
#
# Fedora Gsearch Admin User info
#
#---------------------------------------------
#
export FEDORA_GSEARCH_ADMIN_USER="FGSADMIN_USER_TO_CHANGE"       		# Name of gsearch admin user
export FEDORA_GSEARCH_ADMIN_PASS="FGSADMIN_PASS_TO_CHANGE"        		# gsearch admin password
