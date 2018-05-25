#!/usr/bin/env python
import argparse
import os
import re
import sys
import json

program_description = "A command line tool to execute several OOLs. See FIXME for detail."
parser = argparse.ArgumentParser(description=program_description)
parser.add_argument("FILE", help="Program to be executed")
parser.add_argument("-v", "--verbose", help="Detail logging information", action="store_true", default=False)
# parser.add_argument("-p", "--program", help="Program to be executed")
args = parser.parse_args()
input_file_path = args.FILE
file_basename = os.path.basename(input_file_path)
file_full_path = os.path.abspath(input_file_path)
file_dirname, file_name = os.path.split(file_full_path)
# os.path.dirname
file_extension = re.findall(r'\.([^.]+)', file_name)[0]

print(input_file_path)
print(file_name)
print(file_basename)
print(file_full_path)
print(file_dirname)
print(file_extension)

def init():
	# run()
	print()


def select_compiler(ext=None):
	if not ext:
		ext = file_extension
	with open('config.json') as json_data:
		d = json.load(json_data)
		lang_config = d["language"]
		for l in lang_config: 
			lang = lang_config[l]
			compile_cmd = lang["compile_cmd"]
			exec_cmd = lang["exec_cmd"]
			extensions = lang["extensions"]
			print(extensions)
			if ext in extensions:
				return (l, compile_cmd, exec_cmd)
	return None;

def run():
	(l, compile_cmd, exec_cmd) = select_compiler(file_extension)
	if compile_cmd != "":
		compile_cmd = compile_cmd.replace("$FILEPATH", file_full_path)
		print("Compile: ", compile_cmd)
		os.system(compile_cmd)
	exec_cmd = exec_cmd.replace("$DIRNAME", file_dirname)
	exec_cmd = exec_cmd.replace("$FILEPATH", file_full_path)
	exec_cmd = exec_cmd.replace("$BASENAME", file_basename)
	print("Exec: ", exec_cmd)
	os.system(exec_cmd)


# def edit_config():
	# 
	# Config Parser for config files

def verbose_mode(input, basename, dirname, extension):
	print("input_file_path ", input)
	print("file_basename ", basename)
	print("file_dirname ", dirname)
	print("file_extension ", extension)


if __name__ == "__main__":
	init()

# python3 run.py src/subfolder/javatest.java 