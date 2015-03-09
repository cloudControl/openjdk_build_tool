#!/bin/bash
# It reads latest uploaded version and compares it with currently built one.
# If they are different, script will upload new jdk version and update file with latest name.
set -eo pipefail

echo "Checking $2..."
latest=$(curl --silent -L http://packages.$2/buildpack-java/latest$1)
echo "Latest version: $latest"

current=$3
echo "Current version: $current"

if [ "$latest" == "$current" ]; then
    echo "No new build. Doing nothing";
else
    echo "New build found. Uploading to $2"
    echo $current > latest$1

    gs3pload push --env $2 packages/buildpack-java $current -p
    gs3pload push --env $2 packages/buildpack-java latest$1 -p
fi
