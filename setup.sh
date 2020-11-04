#!/usr/bin/env bash
echo 'UPDATED Command 4'
GITHUB_URL='https://raw.githubusercontent.com/andersonoxford/sfdx-commands/master/'
PREFIX="bash <(curl -s ${GITHUB_URL}"
SUFFIX=")"
alias push='${PREFIX}source_push.sh${SUFFIX}'