#!/bin/sh

set -e

_srcPath="${1%/}"
if [ -z "${_srcPath}" ]; then
  echo 'Source path is missing' >&2
  exit 1
fi

_neonPath='/var/www/html/src/addons/DevHelper/PHPStan/phpstan.neon'
_srcNeonPath="${_srcPath}/_files/dev/phpstan.neon"
if [ -f ${_srcNeonPath} ]; then
  _neonPath=${_srcNeonPath}
  echo "Using ${_neonPath}" >&2
fi

export "DEVHELPER_PHPSTAN_SRC_PATH=${_srcPath}"

exec phpstan analyse \
  --autoload-file=/var/www/html/src/addons/DevHelper/PHPStan/autoload.php \
  --level max \
  --memory-limit=-1 \
  --debug \
  -c ${_neonPath} \
  ${_srcPath}
