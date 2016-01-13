# fedora-repository
Process to build an Islandora ready (not included) fedora commons server on a CentOS 7 host. 

The installation process is fairly simple. 

Requirements:
   - CentOS 7 based machine (minimal install is sufficient). 
 

Notes: 
   - an /opt/fedora-repository directory will be created as the installation base.

Installation (quick):

	In order to simplify the installation process we created an init.d service that you can load on 
	the machine to do the installation for you. This automates the manual installation process that is shown further below.

		% cd /etc/init.d
		% wget https://raw.githubusercontent.com/dhinitiative/fedora-repository/master/etc/repository-installer-init-d
		
		modify the repository-installer-init-d script for your email address for root's mail and to notify you:
		edit the line: 
			sed -i "s|youremail@domain.com|<REPLACE WITH YOUR EMAIL>|g" /opt/fedora-repository/installer.sh
			
			change the <REPLACE WITH YOUR EMAIL> to your real email address or the address where all mail for the box should go.
			it should read something like this:
			
				sed -i "s|youremail@domain.com|dhiemail@dhinitiative.org|g" /opt/fedora-repository/installer.sh
				
    			Then run the following commands:
    			
    				% mv repository-installer-init-d repository-installer
				% chmod 755 /etc/init.d/repository-installer
				% chkconfig --add repository-installer
  
   		Now you have a repository-installer service on the machine.
   
   			[root@host ~]# chkconfig --list | grep repository-installer

			Note: This output shows SysV services only and does not include native
			systemd services. SysV configuration data might be overridden by native
			systemd configuration.
			
			If you want to list systemd services use 'systemctl list-unit-files'.
			To see services enabled on particular target use
			'systemctl list-dependencies [target]'.

			repository-installer	0:off	1:off	2:off	3:off	4:off	5:off	6:off
			[root@host ~]# 

		If it's off turn it on with ( chkconfig repository-installer on ) alternatively to turn it off ( chkconfig repository-installer off )

		By enabling this service it will automatically build the fedora server the next reboot. So reboot your machine and sit back and wait up to an hour for the installation to complete. At the end of the process all the login details will be emailed to the root account specified in the instructions above. 

That's it!

	You can also log back in after the reboot and do:

		% tail -f /opt/fedora-repository/installation.log 

	You can watch the install process as it works along building the installation. 

Installation (manually):

    Install needed software:
        % yum -y install git gettext sendmail
        
    Create the installation directory:
    
       % mkdir /opt
       % cd /opt
       
    Get the installation software:
  
       % git clone https://github.com/dhinitiative/fedora-repository.git

    Configure the installation:
    
      % cd /opt/fedora-repository
      
      edit the file installer.sh and modify the values to suit your environment, modify the following:
      
      export ADMIN_EMAIL='youremail@domain.com' 
      export FEDORA_USER_PASS='fedora2014'
      export ROOT_MYSQL_PASS='mysqlroot' 
      export FEDORA_DB_NAME="fedora3"        		            # Name of fedora MySQL database -> fedora3 is recommended
      export FEDORA_DB_USER="fedoradb"        		        # Fedora db username -> for fedora.fcfg file
      export FEDORA_DB_PASS='fedoradbpass'        	        # Fedora db password -> for fedora.fcfg file
      export FEDORA_ADMIN_USER="fedoraAdmin"                  # Username for http://localhost:8080/fedora/admin
      export FEDORA_ADMIN_PASS='fedoraadminpass'              # Password for http://localhost:8080/fedora/admin
      export FEDORA_GSEARCH_ADMIN_USER="fgsAdmin"             # Username for http://localhost:8080/fedoragsearch
      export FEDORA_GSEARCH_ADMIN_PASS='fgsadminpass'  
      
     
     
    Execute the installation:
      % chmod 755 installer.sh
      % ./installer.sh >/opt/fedora-repository/installation.log 2>&1 &
      
  Note: run the command:

    % tail -f /opt/fedora-repository/installation.log 

  To watch the install process as it works along building the installation. 

