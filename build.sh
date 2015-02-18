#!/bin/bash
set -eo pipefail

vagrant destroy $1 -f
vagrant up $1
./package.sh openjdk$1
rm -rf openjdk$1
vagrant destroy $1 -f
