#!/bin/sh
# Copyright (c) 2000-2011 Synology Inc. All rights reserved.

PSQL="/usr/bin/psql"

ExecSqlCommand()
{
	$PSQL -U postgres download -c "$1" > /dev/null 2>&1
}

echo "test seeders in download_queue table"
ExecSqlCommand "Update download_queue set seeders = 0 where task_id = 0"
Ret=$?
if [ $Ret = 1 ]; then
	echo "Create seeders/leechers columns in download"
	Script="/var/packages/DownloadStation/target/scripts/sql/upgrade/002_seeder_leecher.pgsql"
	$PSQL -U postgres download < $Script
	if [ $? != 0 ]; then
		echo "Failed to create seeders/leechers columns in download"
		exit
	fi
fi

