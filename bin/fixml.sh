#!/bin/sh

##find ./ -name '*.m' -exec fixml.sh '{}' \; 2>> err

if [[ $# -ne 1 ]]; then
	echo "$0: need single filename argument" 1>&2
	exit 1
fi

DNM=$(dirname $1)
BNM=$(basename $1)
OLDNM=$1
NEWNM="$DNM/bd_$BNM"

if [[ -e "$NEWNM" ]]; then
	echo "$0: $NEWNM exists already!" 1>&2
	exit 1
else
	mv "$OLDNM" "$NEWNM"
	fixml.awk "$NEWNM" > "$OLDNM"
fi

exit 0
