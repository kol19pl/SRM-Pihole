<?php
define ('LFTP_STATUS_EXT', '.lftp-pget-status');

function rename_lftp_status_file($task_dir)
{
	$task_id = basename($task_dir);
	if (!chdir($task_dir)) {
		return;
	}

	foreach (glob("*".LFTP_STATUS_EXT) as $filename) {
		$target_filename = "$task_id".LFTP_STATUS_EXT;
		if ($filename === $target_filename) {
			continue;
		}
		rename($filename, $target_filename);
	}
}

if (!isset($argv[1])) {
	echo "Need download directory"."\n";
	exit(1);
}

$iterator = new DirectoryIterator($argv[1]);
foreach ($iterator as $file_info) {
	$filename = $file_info->getFilename();
	if ('.' === $filename || '..' === $filename) {
		continue;
	}

	if ($file_info->isDir() && is_numeric($filename)) {
		rename_lftp_status_file($file_info->getPathname());
	}
}

?>
