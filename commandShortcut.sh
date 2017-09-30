#!/bin/bash
# This intends to compile & execute java, python or cpp with
# run command

compilerOptions() {
	printf "[compiler]\t-c\tc++\n"
	printf "\t\t-j\tjava\n"
	printf "\t\t-py\tpython default\n"
	printf "\t\t-py3\tpython 3.5\n"
}

runC() {
	testPrint
	gcc $fileInputName -o $fileBaseName
	./$fileBaseName
}

runJava() {
	testPrint
	javac $fileInputName
	java $fileBaseName
}

runPython() {
	testPrint
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
		then
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
						echo "ERROR! Invalid input"
						echo $fileInputName
						;;
			esac
		else
	   		echo "ERROR! File does not exist!"
	fi
	
}

if [ -z "$1" ]
	then
	    echo "No arguments supplied"
	    echo "============================================="
	    echo "run [compiler] [program name]"
	    echo "---------------------------------------------"
	    compilerOptions
	else
		fileInputName=$1
		main

fi


