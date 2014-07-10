FROM      ubuntu

RUN apt-get update
RUN apt-get -y install mercurial ant gawk g++ libcups2-dev libasound2-dev libfreetype6-dev libx11-dev libxt-dev libxext-dev libxrender-dev libxtst-dev libfontconfig1-dev zip openjdk-7-jdk git make
RUN rm -rf ~/openjdk_build_tool
RUN git clone -b update https://github.com/cloudControl/openjdk_build_tool.git ~/openjdk_build_tool

ENV ALT_BOOTDIR /usr/lib/jvm/java-7-openjdk-amd64
ENV ALT_CACERTS_FILE /etc/ssl/certs/java/cacerts

VOLUME /opt/openjdk
RUN rm -rf /opt/openjdk/*
RUN ~/openjdk_build_tool/build_jdk.sh 7 /opt/openjdk
