echo '-- Powered By: ThinkLP SFDX Commands (0.2) --'
echo 'Run tlp help to see usages'

# This is used to format the error message
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'

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
    show_error "Comma separated class names is required"
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
  # Ask package name
  printf "Enter package name (core|audit): "
  read -r PACKAGE_NAME

  # Check package name is not null
  if [ -z "$PACKAGE_NAME" ]; then
    show_error "Error: Package name is required"
  else
    # Ask scratch name
    printf "Enter scratch name (kebab-case): "
    read -r SCRATCH_NAME

    # Check scratch name is not null
    if [ -z "$SCRATCH_NAME" ]; then
      show_error "Error: Scratch name is required"
    else
      TODAY=$(date +"%Y-%m-%d")
      SCRATCH_NAME="$SCRATCH_NAME"_Core_"$TODAY"
      feedback "Creating new scratch org for $PACKAGE_NAME with name $SCRATCH_NAME"

      # Switch package name
      case "$PACKAGE_NAME" in
      core)
        core_scratch "$SCRATCH_NAME"
        ;;
      audit)
        audit_scratch "$SCRATCH_NAME"
        ;;
      *)
        show_error "The $PACKAGE_NAME package is not supported yet"
        ;;
      esac
    fi
  fi
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
  SCRATCH_NAME="$1"
  sfdx force:org:create -a "$SCRATCH_NAME" -s -f config/project-scratch-def.json --durationdays 30
  feedback "Pushing Core package data to new scratch org..."
  sfdx force:source:push
  sfdx force:user:permset:assign --permsetname Core_Scratch
  feedback 'Permission set assigned'
  feedback 'Creating scratch org data'
  sh data/data_import.sh
  feedback 'Scratch org setup complete! Opening scratch org...'
  sfdx force:org:open
}

audit_scratch() {
  SCRATCH_NAME="$1"
  sfdx force:org:create -a "$SCRATCH_NAME" -s -f config/project-scratch-def.json -d 30
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
  feedback '---------------------------------------------------------------------'
  feedback 'List of ThinkLP SFDX Commands:'
  feedback
  feedback 'tlp push                  (To push project to scratch org)'
  feedback 'tlp test                  (To run a specific test classes)'
  feedback 'tlp push_test             (To execute the push command followed by test command)'
  feedback 'tlp retrieve              (To retrieve specific metadata types from scratch to project)'
  feedback 'tlp pull                  (Similar to retrieve but does not pull CustomLabels)'
  feedback 'tlp auth                  (To authorize the dev hub on your machine)'
  feedback 'tlp help                  (To display the list of ThinkLP SFDX Commands)'
  feedback 'tlp scratch               (To create a scratch org for a package)'
  feedback '---------------------------------------------------------------------'
}

feedback() {
  echo "${GREEN}$1${NOCOLOR}"
}

show_error() {
  echo
  echo "${RED}$1${NOCOLOR}"
  echo
}
