#!/usr/bin/env bash

set -e

_addOnId="${1%/}"
if [ -z "${_addOnId}" ]; then
  echo 'Source path is missing' >&2
  exit 1
fi

_prettierSrc="/var/www/html/.prettierrc"
_customPrettierSrc="/var/www/html/src/addons/${_addOnId}/_files/dev/.prettierrc"
if [ -f "${_customPrettierSrc}" ]; then
    _prettierSrc=${_customPrettierSrc}
    echo "Using: ${_customPrettierSrc}" >&2
fi

exec prettier \
    --config ${_prettierSrc} \
    --ignore-path "/var/www/html/.prettierignore" \
    --write "/var/www/html/src/addons/${_addOnId}/_files/js/**/*.js"
