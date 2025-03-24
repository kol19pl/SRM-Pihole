#!/bin/sh

pkg_version=$(echo "$SYNODL_OLD_PKGVER" | cut -d "-" -f2)

if [ ! -z $pkg_version ] && [ $pkg_version -le 2911 -o $pkg_version -ge 2933 ]; then
	exit 0
fi

service_path=/var/services/download
download_tmp=$(readlink $service_path)
script_dir="/var/packages/${SYNOPKG_PKGNAME}/target/scripts/migrate"
script="$script_dir/001_lftp_status_file.php"

if [ $? != 0 -o -z $download_tmp ]; then
	exit 0
fi

/usr/bin/php -n -d display_errors=Off -d open_basedir=$service_path:$download_tmp $script $download_tmp

exit 0
