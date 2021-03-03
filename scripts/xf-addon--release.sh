#!/bin/bash

_addOnId="${1%/}"
if [[ -z "$_addOnId" ]]; then
	echo "Invalid add-on ID."
	exit 1
fi

cmd-php.sh xf-addon:build-release "${_addOnId}"

if [[ ! -d "/var/www/html/_releases" ]]; then
	mkdir /var/www/html/_releases
fi

cp -af /var/www/html/src/addons/${_addOnId}/_releases/* /var/www/html/_releases/
rm -rf /var/www/html/src/addons/${_addOnId}/_releases