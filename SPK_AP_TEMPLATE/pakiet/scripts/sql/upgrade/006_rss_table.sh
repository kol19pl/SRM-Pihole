#!/bin/sh
# Copyright (c) 2000-2011 Synology Inc. All rights reserved.

PSQL="/usr/bin/psql"

ExecSqlCommand()
{
	$PSQL -U postgres download -c "$1" > /dev/null 2>&1
}

echo "test rss_feed table in download db"
ExecSqlCommand "Update rss_feed set title = '' where id = 0"
Ret=$?
if [ $Ret = 1 ]; then
	echo "Create rss tables in download db"
	Script="/var/packages/DownloadStation/target/scripts/sql/upgrade/006_rss_table.pgsql"
	$PSQL -U postgres download < $Script
	if [ $? != 0 ]; then
		echo "Failed to create rss table in download"
		exit
	fi
fi

