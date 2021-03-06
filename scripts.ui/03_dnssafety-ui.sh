#!/bin/bash

# all packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# default arc
MAJOR="0.7.0"
MINOR="C39D"
ARCH="amd64"

# download
wget http://packages.diladele.com/dnssafety-ui/$MAJOR.$MINOR/$ARCH/release/ubuntu18/dnssafety-ui-$MAJOR.${MINOR}_$ARCH.deb

# install
dpkg --install dnssafety-ui-$MAJOR.${MINOR}_$ARCH.deb

# generate the configuration files once
# sudo -u websafety python3 /opt/websafety/var/console/generate.py

# let UI of Dns Safety manage the network
sudo -u daemon python3 /opt/dnssafety-ui/var/console/utils.py --network=ubuntu18

# relabel folder
chown -R daemon:daemon /opt/dnssafety-ui
