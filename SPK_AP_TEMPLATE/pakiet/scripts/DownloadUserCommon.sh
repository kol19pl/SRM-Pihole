#!/bin/sh

#Conf dir/file definition
FILE_DOWNLOADNG_PKG_INFO=/var/packages/DownloadStation/INFO
FILE_DOWNLOADNG_PKG_ENABLE=/var/packages/DownloadStation/enabled

PackageInfoGet(){
	if [ -f "${FILE_DOWNLOADNG_PKG_INFO}" ]; then
		DOWNLOADNG_PKG_NAME=`/bin/get_key_value ${FILE_DOWNLOADNG_PKG_INFO} package`
		DOWNLOADNG_PKG_VERSION=`/bin/get_key_value ${FILE_DOWNLOADNG_PKG_INFO} version`
		DOWNLOADNG_PKG_VENDOR=`/bin/get_key_value ${FILE_DOWNLOADNG_PKG_INFO} maintainer`
		DOWNLOADNG_PKG_MODVER=`/bin/get_key_value ${FILE_DOWNLOADNG_PKG_INFO} sdkmodversion`
	else
		echo "DownloadStation package info file does not exist!";
		exit 1;
	fi
}
		
PackageEnableGet(){
	if [ -f "${FILE_DOWNLOADNG_PKG_ENABLE}" ]; then
		DOWNLOADNG_PKG_ENABLE=1;
	else
		DOWNLOADNG_PKG_ENABLE=0;
	fi
}

SendUSR1ToSchedule(){
	PidFile="/var/run/scheduler.pid"
	if [ -f "$PidFile" ]; then
		Pid=`cat $PidFile`
		kill -USR1 $Pid > /dev/null 2>&1
	fi
}	
