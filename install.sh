#!/bin/bash

if [ ! $(id -u) -eq 0 ]
then
	echo Run this under ROOT only!
	exit 1
fi

for i in bash realpath
do
	if ! which $i > /dev/null
	then
		echo "Install \"$i\" please and repeate installing"
		exit 1
	fi
done

curDir="$(dirname $(realpath $0))"

pushd /usr/local/bin
ln -s "$curDir"/logwrap.sh logwrap
popd
