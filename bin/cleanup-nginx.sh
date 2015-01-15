#!/usr/bin/env bash

# Remove any previous nginx configurations

SITES=/etc/nginx/sites-available/*

for file in $SITES; do
    name=$(basename $file)

    if [[ "$name" != "default" && "$name" != "nexus" ]]; then
        unlink $file
        rm -f $file
    fi
done