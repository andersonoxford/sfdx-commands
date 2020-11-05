echo '-- Powered By: ThinkLP SFDX Commands V.1.4--'

tlp() {
  # Check if function name is supplied
  if [ -z "$1" ]; then
    echo "No function name supplied. Use tlp help to see the list of commands"
  # Switch function name
  else
    case $1 in
    push)
      push "$2"
      ;;
    test)
      test "$2" "$3"
      ;;
    *)
      echo -n "[ $1 ] is not a command"
      ;;
    esac
  fi

}

test() {
  if [ -z "$1" ]; then
    echo "Comma separated class names is required"
  else
    [ ! -d "force-app" ] && cd ../../
    echo "sfdx force:apex:test:run -n $1 $2"
    sfdx force:apex:test:run -n "$1" "$2"
    [ ! -d "force-app" ] && cd ../../
  fi
}

push() {
  [ ! -d "force-app" ] && cd ../../
  echo "sfdx force:source:push $1"
  sfdx force:source:push "$1"
  [ ! -d "force-app" ] && cd ../../
}
