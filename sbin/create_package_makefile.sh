#!/bin/bash -x
. ../../etc/env.sh

INSTALL_CMD="install:"
UNINSTALL_CMD="uninstall:"

for DIR in bin etc include info lib man sbin share
do
	for DIR_CONTENTS in `ls`
	do
		if [ $DIR_CONTENTS == $DIR ]; then
			INSTALL_CMD="$INSTALL_CMD install-$DIR"
			UNINSTALL_CMD="$UNINSTALL_CMD uninstall-$DIR"
		fi	
	done
done
echo $INSTALL_CMD
echo $UNINSTALL_CMD

cp $REPOSITORY_PKGS/Makefile .

sed -i "s|INSTALL_PACKAGE_COMMAND|$INSTALL_CMD|" ./Makefile
sed -i "s|UNINSTALL_PACKAGE_COMMAND|$UNINSTALL_CMD|" ./Makefile
#
# change directory location too
#
sed -i "s|INSTALL_PREFIX_TO_CHANGE|$INSTALL_PREFIX|" ./Makefile
