#!/usr/bin/env bash
[ ! -d "force-app" ] && cd ../../
sfdx force:source:push -f
[ ! -d "force-app" ] && cd ../../