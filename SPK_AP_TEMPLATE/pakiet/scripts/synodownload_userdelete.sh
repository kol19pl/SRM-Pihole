#!/bin/sh
# Copyright (c) 2000-2011 Synology Inc. All rights reserved.

#Include common scripts
FILE_DOWNLOADNG_INC_SCRP=/usr/local/libexec/DownloadUserCommon.sh
. ${FILE_DOWNLOADNG_INC_SCRP}

#At begining, acquire package settings
PackageInfoGet;

case $1 in
	--sdk-mod-ver)
		#Print SDK support version
		echo ${DOWNLOADNG_PKG_MODVER};
	;;
	--name)
		#Print package name
		echo ${DOWNLOADNG_PKG_NAME};
	;;
	--pkg-ver)
		#Print package version
		echo ${DOWNLOADNG_PKG_VERSION};
	;;
	--vendor)
		#Print package vendor
		echo ${DOWNLOADNG_PKG_VENDOR};
	;;
	--pre)
	;;
	--post)
		PackageEnableGet;
		if [ "1" = "${DOWNLOADNG_PKG_ENABLE}" ]; then
			SendUSR1ToSchedule;
		fi
	;;
	*)
		echo "Usage: $0 --sdk-mod-ver|--name|--pkg-ver|--vendor|--pre|--post"
	;;
esac

