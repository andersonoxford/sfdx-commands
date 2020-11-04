[ ! -d "force-app" ] && cd ../../
echo 'Enter your Test Class Names (comma separated) and then press enter:'
read TEST_NAME
echo 'Running Tests:'
sfdx force:apex:test:run -n $TEST_NAME
[ ! -d "force-app" ] && cd ../../