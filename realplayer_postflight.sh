#!/bin/bash
dir="/System/Library/User Template/English.lproj/Library/Application Support/RealNetworks/"

for folder in /Users/*
do
    if [ $folder != "/Users/Shared" ]
    then
	mkdir "$folder/Library/Application Support/RealNetworks/"
	/bin/cp "$dir"* "$folder/Library/Application Support/RealNetworks/"
	chown -R ${folder/\/Users\//} "$folder/Library/Application Support/RealNetworks"
	
    fi
done

exit 0