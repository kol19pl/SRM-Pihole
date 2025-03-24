#!/bin/sh
# Copyright (c) 2000-2011 Synology Inc. All rights reserved.

PSQL="/usr/bin/psql"

ExecSqlCommand()
{
	$PSQL -U postgres download -c "$1" > /dev/null 2>&1
}

echo "test unzip_password column in download_queue table"
ExecSqlCommand "Update download_queue set unzip_password = '' where task_id = 0"
Ret=$?
if [ $Ret = 1 ]; then
	echo "Create unzip_password columns in download"
	Script="/var/packages/DownloadStation/target/scripts/sql/upgrade/009_unzip_password.pgsql"
	$PSQL -U postgres download < $Script
	if [ $? != 0 ]; then
		echo "Failed to create unzip_password column in download"
		exit
	fi
fi

