## Supported OS:

* Ubuntu

## Suported versions:

* 7, 8, 9

## Build:

`build.sh [7|8|9]`

## Automatic upload

To upload built JDK package use `upload.sh` script:

~~~bash
$ upload.sh JDK_NUMBER ENV JDK_PACKAGE
~~~

It requires [`gs3pload`](https://github.com/fern4lvarez/gs3pload) to be installed and configured.

Example upload to single platform:

~~~bash
$ upload.sh 9 devcctrl.com jdk-1.9.0-openjdk-x86_64-1.9.0_b49.tar.gz
~~~

Example upload to multiple platforms:

~~~bash
$ current=jdk-1.9.0-openjdk-x86_64-1.9.0_b49.tar.gz
$ platforms=( devcctrl.com dotcloudapp.com )
$ for i in "${platforms[@]}"; do ./upload.sh 9 $i $current; done
Checking devcctrl.com...
Latest version: jdk-1.9.0-openjdk-x86_64-1.9.0_b49.tar.gz
Current version: jdk-1.9.0-openjdk-x86_64-1.9.0_b52.tar.gz
New build found. Uploading to devcctrl.com
Checking dotcloudapp.com...
Latest version: jdk-1.9.0-openjdk-x86_64-1.9.0_b49.tar.gz
Current version: jdk-1.9.0-openjdk-x86_64-1.9.0_b52.tar.gz
New build found. Uploading to dotcloudapp.com
~~~
