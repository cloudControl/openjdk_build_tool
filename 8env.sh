#!/bin/bash

apt-get update
apt-get -y install git mercurial zip bzip2 unzip tar curl
apt-get -y install ccache make gcc g++ ca-certificates ca-certificates-java
apt-get -y install libX11-dev libxext-dev libxrender-dev libxtst-dev  
apt-get -y install libasound2-dev libcups2-dev libfreetype6-dev
apt-get -y install build-essential ruby-dev pkg-config
apt-get -y install openjdk-7-jdk 

mkdir ~/openjdkathome
cd ~/openjdkathome
git clone https://github.com/hgomez/obuildfactory.git
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
XPACKAGE_MODE=generic XUSE_NEW_BUILD_SYSTEM=true XBUILD=true ./obuildfactory/openjdk8/linux/standalone-job.sh
cp -rf /root/openjdkathome/OBF_DROP_DIR/openjdk8 /home/vagrant
