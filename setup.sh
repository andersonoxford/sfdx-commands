echo '-- Powered By: ThinkLP SFDX Commands V.1.8--'

tlp() {
  # Check if function name is supplied
  if [ -z "$1" ]; then
    echo "No function name supplied. Use tlp help to see the list of commands"
  # Switch function name
  else
    [ ! -d "force-app" ] && cd ../../
    "$1" "$2" "$3"
    [ ! -d "force-app" ] && cd ../../
  fi
}

test() {
  if [ -z "$1" ]; then
    echo "Comma separated class names is required"
  else
    echo "sfdx force:apex:test:run -n $1 $2"
    sfdx force:apex:test:run -n "${1}${2:+-$2}"
  fi
}

push() {
  echo "sfdx force:source:push $1"
  sfdx force:source:push "$1"
}
