#!/bin/sh
# Copyright (c) 2000-2011 Synology Inc. All rights reserved.

PACKAGE_DIR="/var/packages/pi-hole"
PACKAGE_TARGET_DIR="${PACKAGE_DIR}/target"
PACKAGE_ETC_DIR="${PACKAGE_DIR}/etc"
Scheduler="${PACKAGE_TARGET_DIR}/sbin/scheduler"
PidFile="/var/run/scheduler.pid"
KERNEL_VERSION=`uname -r`
SwapScript="/usr/syno/bin/swapaction"
PSQL="/usr/bin/psql"

MAXDISKS=`/bin/get_key_value /etc.defaults/synoinfo.conf maxdisks`
if [ ${MAXDISKS} -eq 0 ]; then
	DISKLESS="yes"
fi

notify-send "Title" "Message"


# Run the automated install script
AUTOMATED_INSTALL_SCRIPT="${PACKAGE_TARGET_DIR}/automated install/basic-install.sh"
if [ -f "$AUTOMATED_INSTALL_SCRIPT" ]; then
    echo "Running automated installation script..."
    bash "$AUTOMATED_INSTALL_SCRIPT"
else
    echo "Automated install script not found at ${AUTOMATED_INSTALL_SCRIPT}"
fi







