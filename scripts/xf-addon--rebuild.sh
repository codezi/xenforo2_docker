#!/usr/bin/env bash

set -e

_addOnId="${1%/}"
if [[ -z "$_addOnId" ]]; then
	echo "Invalid add-on ID."
	exit 1
fi

exec cmd-php.sh xf-addon:rebuild "${_addOnId}"