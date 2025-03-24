#!/bin/sh
# Copyright (c) 2000-2008 Synology Inc. All rights reserved.

PSQL="/usr/bin/psql"

ExecSqlCommand()
{
	$PSQL -U postgres download -c "$1" > /dev/null 2>&1
}

echo "set torrent task_flags in download_queue"
ExecSqlCommand "Update download_queue set task_flags=task_flags|4 where length(torrent) > 0 and (task_flags & 6) = 0"

