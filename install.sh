#!/bin/bash

new_version='1.0.0'
config_path=~/.runconfig
bash_profile_path=~/.bash_profile
run_path=/usr/local/bin/run

# Compile to UNIX executable and move to /usr/local/lbin
install_RUN() {
	cd src/
	cp commandShortcut.sh run
	chmod +x run
	cp run '/usr/local/bin/'

	# Add "run" alias to bash_profile
	# echo "alias run='/usr/local/bin/run'" >> bash_profile_path
	# source bash_profile_path
}

# Check if "run" is installed correctly
is_install_success() {
	echo
}

# Current install status and version check
# $1 Current version, $2 New version
check_current_install() {
	if [ "$1" == "$2" ]; then
		echo "Same version $1 is already installed, exiting ..."
		exit
	fi
}

update_config() {
	current_time=$(date +"%r %a %d %h %y")
	touch .runconfig_tmp
	echo "version='$new_version'" > .runconfig_tmp
	echo "last_time_updated='$current_time'" >> .runconfig_tmp
	echo "install_path=$run_path" >> .runconfig_tmp
	echo "config_path=$config_path" >> .runconfig_tmp
	cp .runconfig_tmp ~/.runconfig
}

if [ -e "$run_path" ]; then
	if [ -e "$config_path" ]; then
		source $config_path
		check_current_install $version $new_version

		echo "Current version $version , new version $new_version"''
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
