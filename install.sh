#!/usr/bin/bash

while true; do
	read -p "u sure m8? " inpoot
	case $inpoot in
		[Yy]* ) break;;
		[Nn]* ) exit;;
		* ) "bad answer mi8! ";;
	esac
done

echo -e "\nOk, let's symlink some dootfiles\n"

get_absolute_path() {
	TARGET_FILE=$1
	while [ -L "TARGET_FILE" ]
	do
		TARGET_FILE=`readlink $TARGET_FILE`
		cd `dirname $TARGET_FILE`
		TARGET_FILE=`basename $TARGET_FILE`
	done
	DIR=`pwd -P`
	echo "$DIR/$TARGET_FILE"
}

find . -type f \
	-not -path './.git*'  \
	-not -path '*install.sh' \
	-not -path '*README.md' -print | \
	while read filename; do
		dst=~/$(basename $filename)
		src=$(get_absolute_path $filename)
		echo "Creating symlink $dst => $src"

		ln -fs $src $dst
	done

source ~/.bashrc

echo -e "\nOK, done\n"
