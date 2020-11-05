#!/usr/bin/env bash
[ ! -d "force-app" ] && cd ../../
echo 'sfdx force:source:retrieve -m "CustomField,CustomObject,CustomLabels"'
sfdx force:source:retrieve -m "CustomField,CustomObject,CustomLabels"
[ ! -d "force-app" ] && cd ../../



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