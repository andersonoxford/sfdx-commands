echo '-- Powered By: ThinkLP SFDX Commands V.1.9--'
echo 'Run tlp help to see usage'

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

help() {
  echo '---------------------------------------------------------------------'
  echo 'List of ThinkLP SFDX Commands:'
  echo
  echo 'tlp push                  (To push project to scratch org)'
  echo 'tlp test                  (To run a specific tests)'
  echo 'tlp push_test             (To push the code before running the tests)'
  echo 'tlp retrieve              (To retrieve specific metadata types from scratch to project)'
  echo 'tlp pull                  (Similar to retrieve but does not pull CustomLabels)'
  echo 'tlp core_scratch          (To create a scratch org for the Core package)'
  echo 'tlp auth_dev_hub          (To authorize the dev hub on your machine)'
  echo 'tlp help_me               (To display the list of ThinkLP SFDX Commands)'
  echo '---------------------------------------------------------------------'
}
