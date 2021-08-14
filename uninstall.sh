#!/bin/bash

if [ ! $(id -u) -eq 0 ]
then
	echo Run this under ROOT only!
	exit 1
fi

tmp=/usr/local/bin/logwrap
if [ -a $tmp ]
then
	rm $tmp
fi

echo "Сам бинарь удалён, но могли остаться файлы логов. Удалите и самостоятельно. Они располагаются в домашней директории. Имена файлов: \"logwrap\" и \"logwrap_files\""
