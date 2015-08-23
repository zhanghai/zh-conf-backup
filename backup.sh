#!/bin/bash

set -e

if [[ ! -d home ]]; then
    echo "ERROR: home is not a directory, make sure you are at top level directory"
    exit 1
fi

# Ensure and init .backup
if [[ ! -d .backup ]]; then
    if [[ -e .backup ]]; then
        echo "ERROR: .backup is not a directory"
        exit 1
    fi
    mkdir .backup
    cd .backup
    git init
    git remote add origin git@github.com:DreaminginCodeZH/zh-conf.git
    cd ..
fi

# Note: Directories starting with . will not be included in the expansion of *. We will only copy and clean */.

# Clean
rm -rf .backup/*/

# Backup
cp -Lr */ .backup/

# Push
cd .backup
git add -A
git commit -m "Backup updated: $(date -R)"
git push -u origin master
