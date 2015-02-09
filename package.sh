#!/bin/bash
# By default build script creates archive with jdk content inside top level directory.
# In order to be compatible with our buildpacks we need to get rid of it.

set -eo pipefail

# Get build archive name
build_archive=$(ls $1 |  grep "jdk.*.tar.xz")
echo "Processing $build_archive..."

# Go into build directory
pushd $1
mkdir tmp

# Extract build to tmp dir and get top archive dir
tar -xf $build_archive -C tmp
content=$(ls tmp)

# Go into jdk content and build new archive
pushd tmp/$content
new_build_archive="${build_archive%".tar.xz"}.tar.gz"
tar -zcf $new_build_archive $(ls .)

popd
popd

# Move jdk archive to current dir and remove tmp one
mv $1/tmp/$content/$new_build_archive .
rm -rf $1/tmp
