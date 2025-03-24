#!/bin/sh
# Copyright (c) 2000-2014 Synology Inc. All rights reserved.

PSQL="/usr/bin/psql"

ExecSqlCommand()
{
	$PSQL -U postgres download -c "$1" > /dev/null 2>&1
}

echo "test task_plugin table in download db"
ExecSqlCommand "Update task_plugin set current_plugin = '' where task_id = 0"
Ret=$?
if [ $Ret = 1 ]; then
	echo "Create task_plugin tables in download db"
	Script="/var/packages/DownloadStation/target/scripts/sql/upgrade/012_plugin.pgsql"
	$PSQL -U postgres download < $Script
	if [ $? != 0 ]; then
		echo "Failed to create task_plugin table in download"
		exit
	fi
fi

