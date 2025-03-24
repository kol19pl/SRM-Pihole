#!/bin/sh
# Copyright (c) 2000-2015 Synology Inc. All rights reserved.

PSQL="/usr/bin/psql"

ExecSqlCommand()
{
	$PSQL -U postgres download -c "$1" > /dev/null 2>&1
}

echo "test completed_time column in download_queue table"
ExecSqlCommand "Update download_queue set completed_time = 0 where task_id = 0"
Ret=$?
if [ $Ret = 1 ]; then
	echo "Create completed_time column in download"
	Script="/var/packages/DownloadStation/target/scripts/sql/upgrade/015_completed_time.pgsql"
	$PSQL -U postgres download < $Script
	if [ $? != 0 ]; then
		echo "Failed to create completed_time column in download"
		exit
	fi
fi

