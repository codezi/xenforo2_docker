#!/bin/bash

_addOnId="$1"
if [[ -z "$_addOnId" ]]; then
	echo "Invalid add-on ID."
	exit 1
fi

cd /var/www/html && php cmd.php xf-addon:inspection ${1:0:-1}