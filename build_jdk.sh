#!/usr/bin/env bash

#########################################################

versions=(["6"]="http://hg.openjdk.java.net/jdk6/jdk6" 
          ["7"]="http://hg.openjdk.java.net/jdk7u/jdk7u" 
          ["8"]="http://hg.openjdk.java.net/jdk8/jdk8")

#########################################################

# download [6|7|8] [repo_directory]
download(){
  echo "===>> Download"
  cwd=$(pwd)
  
  if [ ! -d $2 ]; then echo "Directory does not exist: ${2}" ; return 1 ; fi
  url=${versions["$1"]}
  echo "Cloning ${url} to ${2}"
  hg clone ${url} ${2}
  if [ $? -ne 0 ]; then echo "Failed to clone ${url} repository." ; return 1 ; fi
  cd ${2} ; 
  echo "Checking out ${3} version"
  hg checkout ${3}
  sh "./get_source.sh"
  if [ $? -ne 0 ]; then echo "Failed to get jdk sources" ; cd ${cwd} ; return 1 ; fi 
  
  cd ${cwd}
  echo "===>> Done."
  return 0
}

# prepare_env [6|7|8] [repo_directory] [build_number]
prepare_env(){
  echo "===>> Setting build env"
  echo "===>> Build number: ${3}"
  unset JAVA_HOME
  export LANG=C
  export ALLOW_DOWNLOADS=true
  export EXTRA_LIBS=/usr/lib/x86_64-linux-gnu/libasound.so
  export DISABLE_HOTSPOT_OS_VERSION_CHECK=ok
  export BUILD_NUMBER=$3
  export JDK_BUILD_NUMBER=$3
  source $2/jdk/make/jdk_generic_profile.sh
  echo "===>> Done."
  return 0
}

# build [repo_directory]
build(){
  echo "===>> Build"
  cwd=$(pwd)
  
  cd $1 ; 
  if [ -f configure ]; then
    bash configure  --with-cacerts-file=${ALT_CACERTS_FILE} --with-boot-jdk=${ALT_BOOTDIR} --with-build-number=${BUILD_NUMBER} --with-update-version=${BUILD_NUMBER}
  else
    make sanity;
  fi
  if [ $? -ne 0 ]; then echo "Sanity check failed." ; cd ${cwd} ; return 1 ; fi 
  make all FULL_DEBUG_SYMBOLS=0
  if [ $? -ne 0 ]; then echo "Build failed." ; cd ${cwd} ; return 1 ; fi
  
  cd ${cwd}
  echo "===>> Done."
  return 0
}

# create_jdk_archive [archive_file_name] [repo_directory] [version]
create_jdk_archive(){
  echo "===>> Creating archive"
  cwd=$(pwd)

  jdkDir="${2}/build/$(get_build_dir_name ${2}/build/ ${3})/j2sdk-image/"
  if [ ! -d ${jdkDir} ]; then echo "Directory does not exist: ${jdkDir}" ; return 1 ; fi
  cd ${jdkDir} ;
  if [ -f release ]; then
    tar -zcf "${cwd}/${1}" ASSEMBLY_EXCEPTION LICENSE THIRD_PARTY_README bin include jre lib release
  else
    tar -zcf "${cwd}/${1}" ASSEMBLY_EXCEPTION LICENSE THIRD_PARTY_README bin include jre lib
  fi
  if [ $? -ne 0 ]; then echo "Archive creation failed." ; cd ${cwd} ; return 1 ; fi

  cd ${cwd}
  echo "===>> Done."
  return 0;
}

# get_build_dir_name [jdk_build_directory] [version] - not nice solution but does the job
get_build_dir_name(){
  if [ "$2" == "8" ]; then
    echo "$(ls ${1})/images";
  else
    echo "$(ls ${1})"
  fi
}

# for future use
get_platform(){
  OSNAME=$(uname -s)
  if [ ${OSNAME} = "Linux" ]; then
    echo "linux"
  elif [ ${OSNAME} = "Darwin" ]; then
    echo "bsd"
  else
    echo "unsupported"
  fi
}

# for future use
get_architecture(){
  echo "amd64"
}

# do_all [6|7|8] [directory] [build_number]
do_all(){
  repoDir="${2}/${1}"
  if [ ! -d $2 ]; then echo "Directory does not exist: ${2}" ; return 1 ; fi
  mkdir -p ${repoDir}
  download $1 ${repoDir} ${3}
  if [ $? -ne 0 ]; then return 1 ; fi
  prepare_env ${1} ${repoDir} ${3}
  if [ $? -ne 0 ]; then return 1 ; fi
  build ${repoDir}
  if [ $? -ne 0 ]; then return 1 ; fi
  create_jdk_archive "${2}/openjdk${1}.${3}.tar.gz" ${repoDir} ${1}
}

do_all $1 $2 $3;
