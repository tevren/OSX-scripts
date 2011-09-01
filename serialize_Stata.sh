#!/bin/bash
dir="/System/Library/User Template/English.lproj/Library/Preferences/Stata 11 Preferences/"

for folder in /Users/*
do
    if [ $folder != "/Users/Shared" ]
    then
	mkdir "$folder/Library/Preferences/Stata 11 Preferences"
	/bin/cp "$dir"* "$folder/Library/Preferences/Stata 11 Preferences/"
	chown -R ${folder/\/Users\//} "$folder/Library/Preferences/"
	
    fi
done

exit 0