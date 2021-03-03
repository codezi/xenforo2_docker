#!/bin/bash

set -e

_addOnId="${1%/}"
if [[ -z "$_addOnId" ]]; then
	echo "Invalid add-on ID."
	exit 1
fi

_configPath="/var/www/html/.php_cs"
_addOnDir="/var/www/html/src/addons/${_addOnId}"
if [ -f "${_addOnDir}/_files/dev/.php_cs" ]; then
    _configPath="${_addOnDir}/_files/dev/.php_cs"
    echo "Using custom config: ${_configPath}"
fi

export "PHPCSFIXER_ADDON_ID=${_addOnId}"

exec php-cs-fixer fix "${_addOnDir}" \
	--show-progress=run-in \
	--path-mode=intersection \
	--config=${_configPath}