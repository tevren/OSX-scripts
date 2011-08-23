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
/bin/rm -rf $userHomeDir
/usr/bin/ditto -rsrcFork $templateHomeDir $userHomeDir
/usr/sbin/chown -R ${USER}:${labGroup} $userHomeDir
/bin/chmod 775 $userHomeDir

# stops users from changing background
/usr/sbin/chown root:wheel $userHomeDir/Library/Safari/Safari\ Desktop\ Picture.jpg
/bin/chmod 744 $userHomeDir/Library/Preferences/Safari/Safari\ Desktop\ Picture.jpg

if [ -e "$templateKeychain".orig ]
then
    /bin/mv -f $templateKeychain.orig $templateKeychain
fi

#the finder plist has to be owned by root so that the current user may not change it
/usr/sbin/chown root:wheel $userHomeDir/Library/Preferences/com.apple.finder.plist
/bin/chmod 755 $userHomeDir/Library/Preferences/com.apple.finder.plist

#fix permissions for adobe media encoder
/usr/sbin/chown -R root:staff $userHomeDir/Library/Preferences/Adobe/Adobe*Media*Encoder/


echo "$USER logged in at $(date) on $(hostname)" >> $activityLogFile

exit 0