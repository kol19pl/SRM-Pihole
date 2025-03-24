#!/bin/sh
# Copyright (c) 2000-2011 Synology Inc. All rights reserved.

PSQL="/usr/bin/psql"

ExecSqlCommand()
{
	$PSQL -U postgres download -c "$1" > /dev/null 2>&1
}

echo "test is_regex column in rss_filter table"
ExecSqlCommand "Update rss_filter set is_regex = FALSE where id = 0"
Ret=$?
if [ $Ret = 1 ]; then
	echo "Create is_regex columns in rss_filter"
	Script="/var/packages/DownloadStation/target/scripts/sql/upgrade/011_rss_regex.pgsql"
	$PSQL -U postgres download < $Script
	if [ $? != 0 ]; then
		echo "Failed to create is_regex column in rss_filter"
		exit
	fi
fi

