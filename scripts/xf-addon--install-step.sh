#!/bin/bash

set -e

_addOnId="${1%/}"
if [[ -z "$_addOnId" ]]; then
	echo "Invalid add-on ID."
	exit 1
fi

shift 1

exec cmd-php.sh xf-addon:install-step "${_addOnId}" "$@"