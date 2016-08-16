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

find . -type f \
	-not -path './.git*'  \
	-not -path '*install.sh' \
	-not -path '*README.md' -print | \
	while read filename; do
		dst=~/$(basename $filename)
		src=$(readlink -f $filename)
		echo "Creating symlink $dst => $src"

		ln -fs $src $dst
	done

echo -e "\nOK, done\n"
