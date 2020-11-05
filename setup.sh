echo '-- Powered By: ThinkLP SFDX Commands V.1.5--'

tlp() {
  # Check if function name is supplied
  if [ -z "$1" ]; then
    echo "No function name supplied. Use tlp help to see the list of commands"
  # Switch function name
  else
    "$1" "$2" "$3"
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
