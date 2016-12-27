#!/bin/bash

while getopts ":a:" opt; do
	case $opt in
	a) 
	echo "-a was trigered,  Paramter: $OPTARG" >&2
	;;
	\?)
	echo "invalide option: -$OPTARG" >&2
	;;
        :)
	echo "Option -$OPTARG require an argment" >&2
	exit 1
	;;
    esac
done
echo "\$1=" $1
shift 1
echo "\$1=" $1
echo "OPTIND=" $OPTIND
#shift "$((OPTIND -1))"
#shift $((OPTIND -1 ))
echo "OPTINDafter=" $OPTIND
echo "\$1=" $1
if [[ ! $1 ]]
then
	echo "wrong usage"
	exit 1
fi


#rember dev name
p0=$1
p1=$1"1"
p2=$1"2"
echo $p1
echo $p2

