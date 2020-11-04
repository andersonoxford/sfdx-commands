echo 'UPDATED Command 5'
GITHUB_URL='https://raw.githubusercontent.com/andersonoxford/sfdx-commands/master/'
PREFIX="zsh <(curl -s ${GITHUB_URL}"
SUFFIX=")"
alias push='${PREFIX}source_push.sh${SUFFIX}'