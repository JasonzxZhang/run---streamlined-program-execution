import argparse
import os
import sys
program_description = "A command line tool to execute several OOLs. See FIXME for detail."
parser = argparse.ArgumentParser(description=program_description)
parser.add_argument("FILE", help="Program to be executed")
parser.add_argument("-v", "--verbose", help="Detail logging information", action="store_true", default=False)
# parser.add_argument("-p", "--program", help="Program to be executed")
args = parser.parse_args()

# print(sys.argv)
input_file_path = args.FILE
file_basename = os.path.basename(input_file_path)
parent_folder =
file_extension = 
# filePath=$(dirname "$fileInputName./")
# fileFullName=$(basename "$fileInputName")
# fileBaseName="${fileFullName%.*}"
# fileExt="${fileFullName##*.}"
print("Program: ", args.FILE)
command="python " + args.FILE
os.system(command)

# Config Parser for config files