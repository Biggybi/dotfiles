#!/bin/bash

CHECK='@le-101'

if [ $# == 0 ]
then
	$1 = .
fi

for f in $(find $1 -type f -name *\.h -o -name *\.c)
do
	if grep -n $CHECK $f | grep 6:.\*
	then
		sed -i '1,13d' $f
	fi
	vim -c 'call Stdheader() | :wqa' $f
done
