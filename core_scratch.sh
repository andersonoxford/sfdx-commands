[ ! -d "force-app" ] && cd ../../
TODAY=$(date +"%Y%m%d")
SCRATCH_NAME=`openssl rand -base64 6`
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