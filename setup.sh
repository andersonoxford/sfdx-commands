#!/usr/bin/env bash
echo 'UPDATED Command 2'
GITHUB_URL='https://raw.githubusercontent.com/andersonoxford/sfdx-commands/master/'
PREFIX="bash <(curl -s ${GITHUB_URL}"
SUFFIX=")"
echo "${PREFIX}source_push.sh${SUFFIX}"
#alias push='${PREFIX}source_push.sh${SUFFIX}'
alias push='bash <(curl -s https://raw.githubusercontent.com/andersonoxford/sfdx-commands/master/source_push.sh)'

