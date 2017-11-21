#!/bin/bash
# This intends to compile & execute java, python or cpp with
# run command
# Shall be installed under /usr/loca/bin

VERSION=1.0.0
AUTHOR="Jason Zhang"
DATE="2017-11-19"

compilerOptions() {
	printf "[compiler]\t-c\tc++\n"
	printf "\t\t-j\tjava\n"
	printf "\t\t-py\tpython default\n"
	printf "\t\t-py3\tpython 3.5\n"
}

runC() {
	echo "Compiling with "gcc --version
	g++ $fileInputName -o $fileBaseName
	./$fileBaseName
}

runJava() {
	javac $fileInputName
	java $fileBaseName
}

runPython() {
	python $fileInputName
}

testPrint() {
	echo "FILE_PATH-> "$filePath
	echo "FILE_FULLNAME-> "$fileFullName
	echo "FILE_BASENAME-> "$fileBaseName
	echo "FILE_EXTENSION-> "$fileExt
}

main() {
	if [ -e $fileInputName ]
		# FIXME - add verbose mode there
		then
			# Extract targeted file info 
		    filePath=$(dirname "$fileInputName./")
			fileFullName=$(basename "$fileInputName")
			fileBaseName="${fileFullName%.*}"
			fileExt="${fileFullName##*.}"
			case $fileExt in
				'cpp')
						runC
						;;
				'java')
						runJava
						;;
				'py')
						runPython
						;;
				*)
						echo "ERROR! Invalid/Incompatible file input"
						echo $fileInputName
						;;
			esac
		else
	   		echo "ERROR! File does not exist!"
	fi
	
}

# Checking for empty input
if [ -z "$1" ]
	then
	    echo "No arguments supplied"
	    echo "============================================="
	    echo "run <program name>"
	    echo "---------------------------------------------"
	else
		fileInputName=$1
		main

fi


