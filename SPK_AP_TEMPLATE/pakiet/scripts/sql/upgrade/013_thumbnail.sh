#!/bin/sh
# Copyright (c) 2000-2014 Synology Inc. All rights reserved.

PSQL="/usr/bin/psql"

ExecSqlCommand()
{
	$PSQL -U postgres download -c "$1" > /dev/null 2>&1
}

echo "test thumbnail table in download db"
ExecSqlCommand "Update thumbnail set thumbnail_filename = '' where thumbnail_id = 0"
Ret=$?
if [ $Ret = 1 ]; then
	echo "Create thumbnail tables in download db"
	Script="/var/packages/DownloadStation/target/scripts/sql/upgrade/013_thumbnail.pgsql"
	$PSQL -U postgres download < $Script
	if [ $? != 0 ]; then
		echo "Failed to create thumbnail table in download"
		exit
	fi
fi

