#!/bin/sh
# Copyright (c) 2000-2012 Synology Inc. All rights reserved.

PACKAGE_DIR="/var/packages/DownloadStation"
LEGACY_PATH=${PACKAGE_DIR}/target/etc/SYNO.SDS.DownloadStation.Application.legacy.conf

case $1 in
	add)
		ln -sf $LEGACY_PATH /etc/httpd/sites-enabled/SYNO.SDS.DownloadStation.Application.legacy.conf
		;;
	delete)
		rm /etc/httpd/sites-enabled/SYNO.SDS.DownloadStation.Application.legacy.conf
		;;
	hupapache)
		kill -SIGUSR1 `cat /var/run/httpd-sys.pid` > /dev/null
		;;
	*)
		;;
esac
