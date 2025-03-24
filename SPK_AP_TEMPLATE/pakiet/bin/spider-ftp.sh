#!/bin/sh

if /var/packages/DownloadStation/target/bin/wget-spider "$@" 2>&1 | grep "No such file"; then
	exit 1
fi
if /var/packages/DownloadStation/target/bin/wget-spider "$@" 2>&1 | grep "No such directory"; then
	exit 1
fi
exit 0
