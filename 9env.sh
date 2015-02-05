#!/bin/bash

apt-get update
apt-get -y install git mercurial zip bzip2 unzip tar curl
apt-get -y install ccache make gcc g++ ca-certificates ca-certificates-java
apt-get -y install libX11-dev libxext-dev libxrender-dev libxtst-dev  
apt-get -y install libasound2-dev libcups2-dev libfreetype6-dev
apt-get -y install build-essential ruby-dev pkg-config
apt-get -y install openjdk-7-jdk 
gem install fpm

tar -xvvf /vagrant/misc/jdk-1.8.0-openjdk-x86_64-1.8.0_u60-b01.tar.xz

mkdir ~/openjdkathome
cd ~/openjdkathome
git clone -b fix-openjdk9-package-script https://github.com/mkorszun/obuildfactory.git
export JAVA_HOME=/home/vagrant/jdk1.8.0_60
XPACKAGE_MODE=generic XPACKAGE=true XCLEAN=true XUSE_NEW_BUILD_SYSTEM=true XBUILD=true ./obuildfactory/openjdk9/linux/standalone-job.sh
cp -rf /root/openjdkathome/OBF_DROP_DIR/openjdk9 /vagrant
