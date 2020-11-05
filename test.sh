test() {
  [ ! -d "force-app" ] && cd ../../
  echo "sfdx force:apex:test:run -n $1 $2"
  sfdx force:apex:test:run -n "$1" "$2"
}