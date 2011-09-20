#!/bin/bash

USER=$1
labUser=culuser
labGroup=lib_pub
manageDir=/Library/Management
scriptDir=${manageDir}/bin
scriptLogFile=${manageDir}/bin/log/login-wrapper.log
activityLogFile=${manageDir}/bin/log/activity.log
userHomeDir=/Users/$USER
templateHomeDir=/Users/culuser
templateKeychain=/Users/culuser/Library/Keychains/login.keychain

echo %WINDOWLEVEL HIGH
echo %UIMODE AUTOCRATIC

echo %100
echo Logging In...

if [ -z "$USER" ] 
then
    echo "No user specified!" >> $scriptLogFile
    exit 1
fi

if [ $USER = "lito" -o $USER = "culuser" ] 
then
    exit 0
fi

#removes user's keychain file
if [ -e "$templateKeychain" ]
then
    /bin/mv -f $templateKeychain $templateKeychain.orig 
fi

# check against SLAuth if user is authorized to use the machine
$scriptDir/mauth.pl $USER 1 >> $scriptLogFile 2>&1
if [ $? -ne 0 ]
then
    # rejected
    echo "You are not authorized to use this computer"
    sleep 2
    /usr/bin/killall loginwindow
    osascript -e 'tell application "System Events" to log out'
fi

# create user's homedirectory from template
if [ -d "$userHomeDir" ]
then
        /usr/sbin/chown -R ${USER}:${labGroup} $userHomeDir
        /bin/chmod 775 $userHomeDir
else
        /usr/bin/ditto -rsrcFork $templateHomeDir $userHomeDir
        /usr/sbin/chown -R ${USER}:${labGroup} $userHomeDir
        /bin/chmod 775 $userHomeDir
fi

if [ -e "$templateKeychain".orig ]
then
    /bin/mv -f $templateKeychain.orig $templateKeychain
fi

/usr/bin/plutil -lint -s $userHomeDir/Library/Preferences/com.apple.dock.plist
echo "$USER logged in at $(date) on $(hostname)" >> $activityLogFile

exit 0