#!/bin/bash

latest=$(curl http://$2.s3.amazonaws.com/buildpack-java/latest$1)
echo "Latest version: $latest"

current=$3
echo "Current version: $current"

if [ "$latest" == "$current" ]; then
    echo "No new build. Doing nothing";
else
    echo "New build found. Uploading to $2" 
    echo $current > latest$1
    
    # Right now only for s3   
    s3cmd put --acl-public $current s3://$2/buildpack-java/
    s3cmd put --acl-public latest$1 s3://$2/buildpack-java/
fi
