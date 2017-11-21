#!/bin/bash

new_version="1.0.0"
config_path="~/.runconfig"
bash_profile_path="~/.bash_profile"

# Compile to UNIX executable and move to /usr/local/lbin
install_RUN() {
	cd src/
	cp commandShortcut.sh run
	chmod +x run
	cp run '/usr/local/bin/'

	# Add "run" alias to bash_profile
	echo "alias run='/usr/local/bin/run'" >> bash_profile_path
	source bash_profile_path
}

update_config() {
	current_time=$(date +"%r %a %d %h %y")
	touch config_path
	echo "version='$new_version'" > ~/.runconfig
	echo "last_time_updated=$current_time" > ~/.runconfig
}

if [ -e '/usr/local/bin/run' ]; then
	if [ -e '~/.runconfig' ]; then
	# Current install status and version check
		source "~/.runconfig"
		if [ "$version" == "$new_version" ]; then
			echo "Same version $version is already installed, exiting ..."
			exit
		fi
		echo "Current version $version is installed, new version $new_version"''
		install_RUN
		update_config
	else
		read -p "Config file is missing or corrupted, proceed to install $new_version anyways? [Y/N] " -n 1 -r
		echo
		if [[ $REPLY =~ ^[Yy]$ ]]; then
		    install_RUN
		    update_config
		else
			echo "Terminated by user."
			exit
		fi
	fi 
else
	read -p "Proceed to install version $new_version? [Y/N] " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
	    install_RUN
	    update_config
	else
		echo "Terminated by user."
		exit
	fi
fi 

