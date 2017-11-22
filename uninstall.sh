#!/bin/bash

source ~/.runconfig
read -p "Proceed to uninstall 'run' version $version? [Y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cp ~/.bash_profile ~/.bash_profile_bk
    cp ~/.bash_profile bash_profile_tmp
	sed -i '' '/alias run=/d' "bash_profile_tmp"
	mv bash_profile_tmp ~/.bash_profile
	rm -f /"usr/local/bin/run"
	rm -f "~/.runconfig"
	source ~/.bash_profile
else
	echo "Terminated by user."
	exit
fi
