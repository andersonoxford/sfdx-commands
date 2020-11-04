#!/usr/bin/env bash
[ ! -d "force-app" ] && cd ../../
echo 'sfdx force:source:push -f'
sfdx force:source:push -f
[ ! -d "force-app" ] && cd ../../