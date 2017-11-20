#!/bin/bash

# Compile to UNIX executable and move to /user/bin
cd src/
cp commandShortcut.sh run
chmod +x run
cp run '/usr/local/bin/'

# Add "run" alias to bash_profile
# echo "export RUN_DIR='/usr/bin/run'" >> ~/.bash_profile
echo "alias run='/usr/local/bin/run'" >> ~/.bash_profile
source ~/.bash_profile
