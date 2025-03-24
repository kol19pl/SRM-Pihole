#!/bin/sh
# Copyright (c) 2000-2011 Synology Inc. All rights reserved.

PSQL="/usr/bin/psql"

ExecSqlCommand()
{
	$PSQL -U postgres download -c "$1" > /dev/null 2>&1
}

echo "test upload_rate in download_queue table"
ExecSqlCommand "Update download_queue set upload_rate = 0 where task_id = 0"
Ret=$?
if [ $Ret = 1 ]; then
   echo "Create seeding related columns in download"
   Ret=1
   Script="/var/packages/DownloadStation/target/scripts/sql/upgrade/001_download_seedings.pgsql"
   $PSQL -U postgres download < $Script
   if [ $? != 0 ]; then
      echo "Failed to create seeding columns in download"
      exit
   fi
fi

