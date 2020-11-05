echo '-- Powered By: ThinkLP SFDX Commands V.2.0--'
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

push() {
  echo "sfdx force:source:push -f"
  sfdx force:source:push -f
}

test() {
  if [ -z "$1" ]; then
    echo "Comma separated class names is required"
  else
    echo "sfdx force:apex:test:run -n $1 $2"
    sfdx force:apex:test:run -n "${1}${2:+-$2}"
  fi
}

push_test() {
  push
  test "$1" "$2"
}

scratch() {
  case "$1" in
  core)
    core_scratch
    ;;
  *)
    echo "The $1 package is not supported yet"
    ;;
  esac
}

retrieve() {
  command='sfdx force:source:retrieve -m "CustomField,CustomObject,CustomLabels"'
  echo "$command"
  command
}

pull() {
  echo 'sfdx force:source:pull'
  sfdx force:source:pull
}

core_scratch() {
  [ ! -d "force-app" ] && cd ../../
  TODAY=$(date +"%Y%m%d")
  SCRATCH_NAME=$(openssl rand -base64 6)
  SCRATCH_NAME='core-scratch_'$TODAY'_'$SCRATCH_NAME
  echo 'Creating new scratch org for Core with name '$SCRATCH_NAME
  sfdx force:org:create -a $SCRATCH_NAME -s -f config/project-scratch-def.json --durationdays 30
  sh scripts/admin/scratchComponents/migrate_components.sh
  echo 'Pushing Core package data to new scratch org...'
  sfdx force:source:push
  sfdx force:user:permset:assign --permsetname Core_Scratch
  echo 'Permission set assigned'
  echo 'Creating scratch org data'
  sh data/data_import.sh
  echo 'Scratch org setup complete! Opening scratch org...'
  sfdx force:org:open
  [ ! -d "force-app" ] && cd ../../
}

help() {
  echo '---------------------------------------------------------------------'
  echo 'List of ThinkLP SFDX Commands:'
  echo
  echo 'tlp push                  (To push project to scratch org)'
  echo 'tlp test                  (To run a specific test classes)'
  echo 'tlp push_test             (To execute the push command followed by test command)'
  echo 'tlp retrieve              (To retrieve specific metadata types from scratch to project)'
  echo 'tlp pull                  (Similar to retrieve but does not pull CustomLabels)'
  echo 'tlp scratch               (To create a scratch org for a package)'
  echo 'tlp auth_dev_hub          (To authorize the dev hub on your machine)'
  echo 'tlp help                  (To display the list of ThinkLP SFDX Commands)'
  echo '---------------------------------------------------------------------'
}
