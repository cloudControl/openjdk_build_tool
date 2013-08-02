##Supported OS: 

* Ubuntu

##Install dependencies:

* Ubuntu:

		apt-get install mercurial ant gawk g++ libcups2-dev libasound2-dev libfreetype6-dev libx11-dev libxt-dev libxext-dev libxrender-dev libxtst-dev libfontconfig1-dev lesstif2-dev

##Build:

* Ubuntu:

	`export ALT_BOOTDIR=[JAVA_COMPILER_DIR]`

	`build_jdk.sh [VERSION] [DIRECTORY_TO_STORE] [BUILD_NUMBER]`

    where `[BUILD_NUMBER]` reflects mercurial repository tag.

	Eventually custom Certificate Authority file can be specified by:

	`export ALT_CACERTS_FILE=[CUSTOM_CACERTS_FILE]`

##Example:

* Ubuntu:

	`export ALT_BOOTDIR=/usr/lib/jvm/java-6-openjdk`

	`export ALT_CACERTS_FILE=/etc/ssl/certs/java/cacerts`

	`mkdir openjdk ; ./build_jdk.sh 7 openjdk b32`


