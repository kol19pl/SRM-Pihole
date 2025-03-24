#!/bin/sh
# Copyright (c) 2000-2011 Synology Inc. All rights reserved.

PACKAGE_DIR="/var/packages/DownloadStation"
OldFile="${PACKAGE_DIR}/etc/amule/amule.conf"
NewFile="${PACKAGE_DIR}/target/etc/amule/amule.conf"
TmpFile="${PACKAGE_DIR}/etc/amule/amule.conf.tmp"
BackupFile="${PACKAGE_DIR}/etc/amule/amule1.conf.bak"
CheckOldVersion="aMule 2.1.3"
CheckNewVersion="2.2.6"
UpgradeConf=0
AmuleOldVersion=`/bin/get_key_value $OldFile AppVersion`
AmuleNewVersion=`/bin/get_key_value $NewFile AppVersion`
AmuleOldSynoVer=`/bin/get_key_value $OldFile SynoAmuleVersion`
AmuleNewSynoVer=`/bin/get_key_value $NewFile SynoAmuleVersion`

SED="/bin/sed"
MOVE="/bin/mv"
COPY="/bin/cp"

echo "Check current amule version..."
if [ "$AmuleOldVersion" = "$CheckOldVersion" ] && [ "$AmuleNewVersion" = "$CheckNewVersion" ] || [ "$AmuleOldSynoVer" != "$AmuleNewSynoVer" ]; then
    UpgradeConf=1
else
    echo "No need to upgrade amule.conf..."
fi

if [ $UpgradeConf -eq 1 ]; then
    echo "Start synchronizing amule.conf..."
    $COPY $NewFile $TmpFile

    OldMaxUpload=`/bin/get_key_value $OldFile MaxUpload`
    OldMaxDownload=`/bin/get_key_value $OldFile MaxDownload`
    OldPort=`/bin/get_key_value $OldFile Port`
    OldUDPPort=`/bin/get_key_value $OldFile UDPPort`
    OldAutoconnect=`/bin/get_key_value $OldFile Autoconnect`
    OldMaxConnections=`/bin/get_key_value $OldFile MaxConnections`
    OldTempDir=`/bin/get_key_value $OldFile TempDir`
    OldIncomingDir=`/bin/get_key_value $OldFile IncomingDir`    

    $SED -i "/^MaxUpload=/c\\MaxUpload=$OldMaxUpload" $TmpFile 
    $SED -i "/^MaxDownload=/c\\MaxDownload=$OldMaxDownload" $TmpFile
    $SED -i "/^Port=/c\\Port=$OldPort" $TmpFile
    $SED -i "/^UDPPort=/c\\UDPPort=$OldUDPPort" $TmpFile
    $SED -i "/^Autoconnect=/c\\Autoconnect=$OldAutoconnect" $TmpFile
    $SED -i "/^MaxConnections=/c\\MaxConnections=$OldMaxConnections" $TmpFile
    $SED -i "/^TempDir=/c\\TempDir=$OldTempDir" $TmpFile
    $SED -i "/^IncomingDir=/c\\IncomingDir=$OldIncomingDir" $TmpFile

    $MOVE $OldFile $BackupFile
    $MOVE $TmpFile $OldFile 

    echo "Finished synchronizing amule.conf..."
fi
