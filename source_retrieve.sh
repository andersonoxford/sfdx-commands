#!/usr/bin/env bash
[ ! -d "force-app" ] && cd ../../
echo 'sfdx force:source:retrieve -m "CustomField,CustomObject,CustomLabels"'
sfdx force:source:retrieve -m "CustomField,CustomObject,CustomLabels"
[ ! -d "force-app" ] && cd ../../