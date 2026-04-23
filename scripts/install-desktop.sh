#!/bin/sh

set -e 

./install-graphics-amd.sh
./install-gui.sh
./install-user-apps.sh
./install-dev-tools.sh

reboot
