#!/usr/bin/env bash
[ ! -d "force-app" ] && cd ../../
sfdx force:source:retrieve -m "CustomField,CustomObject,CustomLabels"
[ ! -d "force-app" ] && cd ../../