#!/bin/bash

USER=$1
manageDir=/Library/Management
scriptDir=${manageDir}/bin
backupDir=${manageDir}/UserBackups
scriptLogFile=${manageDir}/bin/log/logout-wrapper.log
activityLogFile=${manageDir}/bin/log/activity.log
usageLogFile=/Users/$USER"/Library/Preferences/*Usage.log"
usageLogDir=${manageDir}/bin/log/usage
labUser=culuser
labGroup=lib_pub
userHomeDir=/Users/$USER
templateHomeDir=/Users/culuser

echo %WINDOWLEVEL HIGH
echo %UIMODE AUTOCRATIC

echo "Logging Out..."

if [ -z "$USER" ] 
then
    echo "No user specified!" >> $scriptLogFile
    exit 0
fi

if [ $USER = "lito" -o $USER = "culuser" ]
then
    exit 0
fi

#$scriptDir/mauth.pl $USER 0 >> $scriptLogFile 2>&1

# copy application usage log to log directory
#cat ${usageLogFile} >> ${usageLogDir}/$USER.`date "+%F_%H_.%M_.%S"`.log

# tar up files of user logging out to a backup directory 
#cd /Users/$USER && tar zcf ${backupDir}/$USER.`date "+%F_%H.%M.%S"`.tgz Desktop Documents
#cd /
 
# replace possibly modified labuser home directory with
# a clean copy of the template home directory
# done on logout to make sure the next user always
# gets a clean home directory.
# touches .cleanedhomedir flag file so login knows that
# the user directory has been cleaned.
#/bin/rm -rf $userHomeDir

/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user

echo "$USER logged out at $(date) on $(hostname)" >> $activityLogFile
echo %100