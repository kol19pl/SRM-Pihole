#!/bin/sh
# Copyright (c) 2000-2011 Synology Inc. All rights reserved.

PSQL="/usr/bin/psql"

ExecSqlCommand()
{
	$PSQL -U postgres download -c "$1" > /dev/null 2>&1
}

echo "test uid column in user_setting table"
ExecSqlCommand "Update user_setting set uid = 0 where username = ''"
Ret=$?
if [ $Ret = 1 ]; then
	echo "Create uid column in user_setting table"
	Script="/var/packages/DownloadStation/target/scripts/sql/upgrade/007_user_uid.pgsql"
	$PSQL -U postgres download < $Script
	if [ $? != 0 ]; then
		echo "Failed to create uid column in user_setting table"
		exit
	fi
fi

