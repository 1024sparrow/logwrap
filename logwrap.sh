#!/bin/bash

logFilePath=~/logwrap
substututedFilesListFilePath=~/logwrap_files

declare -i state=0
declare target=
for i in $*
do
    if [[ "$i" == "--help" ]]
    then
        echo 'some help'
        exit 0
    fi
    if [ $state -eq 0 ]
    then
        target="$i"
    fi
    state=$state+1
done

if [ ! $state -eq 1 ]
then
    echo 'incorrect arguments. See help for reference.'
    exit 1
fi

rp=$(realpath $target)
echo $rp >> $substututedFilesListFilePath
pushd $(dirname $target)
    target=$(basename $target)
    if [ ! -f $target ]
    then
        echo "there is no such file: $target"
        exit 1
    fi
    if [ -f logwrap_${target} ]
    then
        echo "already wrapped. Skipped."
        exit 1
    fi
    mv $target logwrap_${target}
    echo "#!/bin/bash

echo \"

\$(date): ${rp} =================================\" >> $logFilePath
declare -i counter=1
for i in \$*
do
    echo \"\$counter.) \$i\" >> /home/boris/logwrap
    counter=\$counter+1
done
$(dirname $rp)/logwrap_$(basename $rp) \$*
" > $target
    chmod +x $target
popd
