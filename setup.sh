echo '-- Powered By: ThinkLP SFDX Commands (0.1) --'
echo 'Run tlp help to see usages'

tlp() {
  # Check if function name is supplied
  if [ -z "$1" ]; then
    echo "No function name supplied. Use tlp help to see the list of commands"
  # Run function
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
    echo "sfdx force:apex:test:run -y -n $1 $2"
    sfdx force:apex:test:run -y -n "${1}${2:+ $2}"
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
  audit)
    audit_scratch
    ;;
  *)
    echo "The $1 package is not supported yet"
    ;;
  esac
}

retrieve() {
  echo sfdx force:source:retrieve -m "CustomField,CustomObject,CustomLabels"
  sfdx force:source:retrieve -m "CustomField,CustomObject,CustomLabels"
}

pull() {
  echo 'sfdx force:source:pull'
  sfdx force:source:pull
}

auth() {
  echo 'sfdx force:auth:web:login -d -a DevHub'
  sfdx force:auth:web:login -d -a DevHub
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

audit_scratch() {
  [ ! -d "force-app" ] && cd ../../
  SCRATCH_NAME=$(openssl rand -base64 12)
  SCRATCH_NAME='audit-scratch-'$SCRATCH_NAME
  echo 'Creating new scratch org for Audit...'
  sfdx force:org:create -a $SCRATCH_NAME -s -f config/project-scratch-def.json -d 30
  echo 'Installing Core onto scratch org...'
  sh scripts/admin/install_core_package.sh
  echo 'Creating scratch org components...'
  sh scripts/admin/components/copy_components.sh
  echo 'Scratch org components created!'
  echo 'Pushing Audit package data to new scratch org...'
  sfdx force:source:push
  echo 'Assigning permission set...'
  sfdx force:user:permset:assign -n Audit_Scratch_Permission_Set
  echo 'Permission set assigned!'
  echo 'Creating scratch org data!'
  sh data/scratch_data_import.sh
  echo 'Scratch org setup complete! Opening scratch org...'
  sfdx force:org:open
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
  echo 'tlp auth                  (To authorize the dev hub on your machine)'
  echo 'tlp help                  (To display the list of ThinkLP SFDX Commands)'
  echo 'tlp scratch               (To create a scratch org for a package)'
  echo '---------------------------------------------------------------------'
}
