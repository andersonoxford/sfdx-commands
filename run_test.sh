[ ! -d "force-app" ] && cd ../../
echo
printf 'Enter your Test Class Names (comma separated) and then press enter: '
read -r TEST_NAME
echo 'Running Tests...'
sfdx force:apex:test:run -y -n $TEST_NAME
[ ! -d "force-app" ] && cd ../../