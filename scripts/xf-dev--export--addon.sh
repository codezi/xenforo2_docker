#!/bin/bash

set -e

_addOnId="${1%/}"
if [[ -z "${_addOnId}" ]]; then
  echo 'Add-on ID is missing' >&2
  exit 1
fi

devhelper-autogen.sh "${_addOnId}"
devhelper-autocheck.sh "${_addOnId}"

_addOnDir="/var/www/html/src/addons/${_addOnId}"
if [ -d "${_addOnDir}/_files/js" ]; then
    devhelper-prettier.sh "${_addOnId}"
fi

devhelper-phpcsfixer.sh ${_addOnId}

# Silently enable the add-on because PHPStan has to resolve XFCP classes
xf-addon--enable.sh --no-interaction "${_addOnId}" >/dev/null 2>&1

devhelper-phpstan.sh "${_addOnDir}"

exec cmd-php.sh xf-dev:export --addon "${_addOnId}"
