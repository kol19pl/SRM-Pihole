#!/bin/sh
# Copyright (c) 2000-2014 Synology Inc. All rights reserved.

PSQL="/usr/bin/psql"

ExecSqlCommand()
{
	$PSQL -U postgres download -c "$1" > /dev/null 2>&1
}

echo "test thumbnail_status column in download_queue table"
ExecSqlCommand "Update download_queue set thumbnail_status = 0 where task_id = 0"
Ret=$?
if [ $Ret = 1 ]; then
	echo "Create thumbnail_status column in download"
	Script="/var/packages/DownloadStation/target/scripts/sql/upgrade/014_download_thumbnail_status.pgsql"
	$PSQL -U postgres download < $Script
	if [ $? != 0 ]; then
		echo "Failed to create thumbnail_status column in download"
		exit
	fi
fi

