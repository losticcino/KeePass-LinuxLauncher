#!/usr/bin/env bash
#
# This is is a quick script built by LoSticinno
# The purpose of this script is simply to ensure dependencies are installed for, and then launch KeePass 2x portable.
#
# Drop this SH file into the same directory as your KeePass portable exe,
#     then link it to anywhere (such as your /home dir or desktop) and launch it from there.

#Test for packages

declare -a ARPKGLIST=("mono-complete" "xdotool" "libcanberra-gtk-module")
declare SAPTCOMMAND=("sudo apt-get install -y")
NEWPKGS=false

SOURCE="${BASH_SOURCE[0]}"
while [ -h "${SOURCE}" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "${SOURCE}" )" >/dev/null && pwd )"
  SOURCE="$(readlink "${SOURCE}")"
  [[ ${SOURCE} != /* ]] && SOURCE="$DIR/${SOURCE}" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "${SOURCE}" )" >/dev/null && pwd )"

for MPKG in "${ARPKGLIST[@]}";
do
  PKGOK=$(dpkg-query -W --showformat='${Status}\n' ${MPKG}|grep "install ok installed")
   if [ "" == "${PKGOK}" ]; then
     SAPTCOMMAND="${SAPTCOMMAND} ${MPKG}"
     NEWPKGS=true
   fi
done

 if [ "${NEWPKGS}" == true ]; then
   echo "The following packages are mising and will be installed: ${SAPTCOMMAND:24}"
   ${SAPTCOMMAND}
 fi

mono $DIR/KeePass.exe &
