test() {
  [ ! -d "force-app" ] && cd ../../
  sfdx force:apex:test:run -n "$1" "$2"
}