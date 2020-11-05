echo '-- Powered By: ThinkLP SFDX Commands --'
push='zsh <(curl -s https://raw.githubusercontent.com/andersonoxford/sfdx-commands/master/source_push.sh)'
test='zsh <(curl -s https://raw.githubusercontent.com/andersonoxford/sfdx-commands/master/run_test.sh)'
push_test='zsh <(curl -s https://raw.githubusercontent.com/andersonoxford/sfdx-commands/master/push_test.sh)'
retrieve='zsh <(curl -s https://raw.githubusercontent.com/andersonoxford/sfdx-commands/master/source_retrieve.sh)'
pull='zsh <(curl -s https://raw.githubusercontent.com/andersonoxford/sfdx-commands/master/source_pull.sh)'
core_scratch='zsh <(curl -s https://raw.githubusercontent.com/andersonoxford/sfdx-commands/master/core_scratch.sh)'
auth_dev_hub='zsh <(curl -s https://raw.githubusercontent.com/andersonoxford/sfdx-commands/master/auth_dev_hub.sh)'
help_me='zsh <(curl -s https://raw.githubusercontent.com/andersonoxford/sfdx-commands/master/help.sh)'

source <(curl -s https://raw.githubusercontent.com/andersonoxford/sfdx-commands/master/test.sh)

tlp() {
  # Check if function name is supplied
  if [ -z "$1" ]; then
    echo "No function name supplied. Use tlp help to see the list of commands"
  # Switch function name
  else
    case $1 in
    push)
      push
      ;;
    test)
      if [ -z "$2" ]; then
        echo "No test class names supplied."
      else
        test "$2"
      fi
      ;;
    *)
      echo -n "Command with the name $1 is not found not "
      ;;
    esac
  fi

}
