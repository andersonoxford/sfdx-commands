[ ! -d "force-app" ] && cd ../../
echo 'sfdx force:source:pull'
sfdx force:source:pull
[ ! -d "force-app" ] && cd ../../